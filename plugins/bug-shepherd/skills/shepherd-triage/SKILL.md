---
name: shepherd-triage
description: Launch parallel agents to check whether old bugs still reproduce on the live site, turning a stale backlog into a prioritized verified list. Use when a bug backlog needs cleaning without reading code.
---

# /shepherd-triage — Mass Reproducibility Check

Launch parallel agents to check whether old bugs still reproduce on the live site. This is the core Bug Shepherd workflow: turning a stale backlog into a prioritized, verified list.

**Audience:** PMs who need to clean a backlog without reading code.

## Arguments

- `{count}` (optional): Number of bugs to triage. Default: 30. Max: 60.

## Workflow

### 1. Load Configuration

Read `.claude/triage.config.yaml` for:
- `project.live_url` — where to reproduce
- `reproduction.parallel_agents` — how many agents to launch (default: 5)
- `reproduction.bugs_per_agent` — bugs per agent (default: 6)
- `reproduction.triage_order` — "priority" (default) or "oldest"
- `safety.*` — all safety rules

### 2. Auto-Sync Backlog

If `.claude/backlog-live.md` is older than 24 hours, run `/shepherd-sync` first.

### 3. Select Bugs to Triage

From `backlog-live.md`, select untriaged bugs (those not marked "Triaged"):
- If `triage_order` is "priority" (default): sort by priority first (Highest > High > Medium > Low > Lowest), then by created date (oldest first) within each priority
- If `triage_order` is "oldest": sort by created date (oldest first), ignoring priority
- Skip bugs already in triage logs
- Respect `{count}` parameter
- Report: "Selected {count} bugs for triage (priorities: {P1}xHighest, {P2}xHigh, {P3}xMedium, {P4}xLow; oldest: {date}, newest: {date})"

### 4. Pre-Triage Safety Filter

Before launching agents, apply safety filters:

For each selected bug, check:
1. **Recent activity**: If comments or updates within `safety.recent_activity_days`, move to "SKIP — Active" list
2. **Active assignee**: If `safety.skip_assigned` is true and bug has an assignee, move to "SKIP — Assigned" list
3. **Never-auto-cancel category**: If bug summary/description matches any `safety.never_auto_cancel` keyword, flag as "ALWAYS HUMAN REVIEW"

Report pre-filter results:
```
Pre-filter: {total} bugs
  {proceed} proceeding to reproduction check
  {skipped_active} skipped (recent activity)
  {skipped_assigned} skipped (has assignee)
  {flagged} pre-flagged for human review (high false-negative category)
```

### 5. Launch Parallel Reproduction Agents

Split remaining bugs into batches and launch parallel agents.

Each agent receives:
- A batch of bug IDs and their details
- The live URL and viewport settings
- The `reproduction-checker` agent bundled with this plugin
- Safety rules to follow

**Agent launch pattern:**
```
Launch {parallel_agents} agents in parallel:
  Agent 1: Bugs {1-6} — Check reproducibility on {live_url}
  Agent 2: Bugs {7-12} — Check reproducibility on {live_url}
  Agent 3: Bugs {13-18} — Check reproducibility on {live_url}
  ...
```

Each agent uses the Reproduction Checker agent definition and returns structured findings.

### 6. Collect and Categorize Results

Merge all agent findings into three categories:

#### Category A: AUTO-CANCEL (High Confidence)
Bugs that match `safety.auto_cancel_rules` patterns AND were not reproduced.
These are safe to cancel without human review.

```markdown
### Auto-Cancel ({count})
These bugs match auto-cancel rules and could not be reproduced.

| Key | Priority | Summary | Rule Matched | Evidence |
|-----|----------|---------|-------------|----------|
```

#### Category B: NEEDS HUMAN REVIEW
Bugs that were not reproduced but DON'T match auto-cancel rules, OR that match `never_auto_cancel` categories.

```markdown
### Needs Human Review ({count})
These bugs were not reproduced but require your judgment.

| Key | Priority | Summary | Why Review Needed | Agent Notes |
|-----|----------|---------|-------------------|-------------|
```

#### Category C: CONFIRMED REPRODUCIBLE
Bugs the agents successfully reproduced on the live site.

```markdown
### Confirmed Reproducible ({count})
These bugs are still present on the live site.

| Key | Priority | Summary | Reproduction URL | Agent Notes |
|-----|----------|---------|-----------------|-------------|
```

#### Category D: CANNOT DETERMINE
Bugs where the agent couldn't reach a conclusion (page errors, ambiguous behavior, etc.)

```markdown
### Cannot Determine ({count})
Agents could not reach a conclusion for these bugs.

| Key | Priority | Summary | Reason | Suggested Action |
|-----|----------|---------|--------|-----------------|
```

### 7. HUMAN REVIEW GATE

**THIS IS MANDATORY. NEVER SKIP.**

Present the full categorized report and explicitly ask for approval:

```
TRIAGE COMPLETE: {total} bugs checked

  Auto-Cancel: {count} (safe to close)
  Human Review: {count} (need your decision)
  Reproducible: {count} (confirmed on live site)
  Cannot Determine: {count} (need more investigation)

Review each category above.

For Auto-Cancel: Type "approve auto-cancel" to proceed, or review individually.
For Human Review: Tell me which to cancel, which to keep, and which to investigate.
For Reproducible: These stay open. Want me to update their priority or add notes?
```

**DO NOT execute any tracker updates until the user explicitly approves.**

### 8. Execute Approved Actions

For each approved cancellation:
1. Add a comment to the tracker explaining the triage result
2. Transition to Cancelled/Closed status
3. If sprint tracking is enabled, add to current sprint (audit trail)
4. Assign to the configured team member (audit trail)

For confirmed reproducible bugs:
1. Optionally add a comment with reproduction evidence
2. Update priority if the user requests

### 9. Write Triage Log

Create `.claude/triage-log-{YYYY-MM-DD}.md`:

```markdown
# Triage Log — {date}

## Summary
- Bugs checked: {total}
- Auto-cancelled: {count}
- Human-cancelled: {count}
- Confirmed reproducible: {count}
- Cannot determine: {count}
- Skipped (pre-filter): {count}

## Detailed Results
{Full categorized tables from step 6}

## Patterns Observed
- {Any recurring themes: e.g., "12 bugs against deprecated feature X"}
- {Age patterns: e.g., "Bugs older than 6 months: 80% not reproducible"}

## Next Steps
- {Recommended follow-up actions}
```

### 10. Update Backlog

Mark triaged bugs in `backlog-live.md` with their triage status.

## Safety Rules Summary

These rules exist because of real incidents. Do not weaken them.

1. **NEVER auto-cancel** bugs matching `safety.never_auto_cancel` categories
2. **NEVER auto-cancel** bugs with recent activity (within `recent_activity_days`)
3. **NEVER auto-cancel** bugs with an active assignee (if `skip_assigned` is true)
4. **ALWAYS present results** for human review before executing ANY tracker updates
5. **Agent can't reproduce != bug doesn't exist.** Bias toward keeping bugs open.
6. **Cost of false cancellation >> cost of keeping open.** When in doubt, flag for human review.

## Error Handling

- Playwright connection failure: Fall back to manual mode, report which bugs need manual checking
- Tracker API failure: Save results locally, allow manual execution later
- Agent timeout: Report partial results, flag timed-out bugs as "Cannot Determine"
