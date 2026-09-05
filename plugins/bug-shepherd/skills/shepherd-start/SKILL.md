---
name: shepherd-start
description: "Open a focused investigation session for one bug: pull its full tracker detail, load past lessons and triage history, and produce an investigation plan. Use when starting work on a single ticket, after /shepherd-sync has built the backlog."
---

# /shepherd-start {TICKET-ID} — Bug Investigation Session

Begin a focused investigation session for a single bug. This command sets up context, loads institutional memory, and prepares a structured investigation plan.

**Audience:** PMs, designers, or developers. No code knowledge required for investigation; code knowledge only needed if you plan to fix it yourself.

## Arguments

- `{TICKET-ID}` (required): The bug tracker ID (e.g., PROJ-1234, #456)

## Workflow

### 1. Load Configuration

Read `.claude/triage.config.yaml` for project settings. If it does not exist, run
the first-run setup in `/shepherd-sync` step 1 to create it from the bundled
template, then continue.

### 2. Pre-Flight Checks

- If `team.git_email` is set, verify: `git config user.email` matches. If not, warn:
  ```
  "Git email mismatch. Expected: {git_email}, Got: {actual}."
  "Fix: git config user.email {git_email}"
  ```
- Verify clean working directory: `git status --porcelain`. If dirty:
  ```
  "Working directory has uncommitted changes. Commit or stash before starting a new session."
  ```
- Check that we're on main/master branch. If not, warn.

### 3. Auto-Sync Backlog

If `.claude/backlog-live.md` doesn't exist or is older than 24 hours, run `/shepherd-sync` first.

### 4. Pull Full Bug Details

Load the appropriate adapter and fetch complete bug details:

**For Jira:**
- Title, description, priority, status, assignee, reporter
- All comments (chronological)
- Attachments and screenshots
- Linked issues
- Sprint history

**For Linear:**
- Title, description, priority, status, assignee
- Comments and activity
- Related issues

**For GitHub Issues:**
- Title, body, labels, assignees
- All comments
- Linked PRs

### 5. Create Working Branch (if developer session)

Only if the user intends to fix (not just investigate):
```bash
git checkout main && git pull origin main
git checkout -b fix/{TICKET-ID}-{slug}
```

Where `{slug}` is a kebab-case summary (max 5 words from the title).

### 6. Load Institutional Memory

Read `.claude/learning-log.md` and search for:
- Previous entries mentioning this ticket ID
- Entries with similar keywords or bug categories
- Common patterns that might apply

If matches found, surface them:
```
Related lessons from past sessions:
- Session {date}: "{lesson summary}" (from {ticket})
- Pattern: "{recurring pattern description}"
```

### 7. Check Triage History

Search all `.claude/triage-log-*.md` files for this ticket ID. If found:
```
Triage history:
- {date}: {status} — "{triage notes}"
```

### 8. Build Investigation Plan

Based on the bug details, generate a structured investigation plan:

```markdown
## Session: {TICKET-ID}

**Bug:** {title}
**Priority:** {priority}
**Reported:** {date} by {reporter}
**Category:** {auto-detected: UI/UX, i18n, performance, functionality, etc.}

### What the reporter described
{Summary of the bug in plain language}

### Reproduction steps
1. Go to {URL from bug report}
2. {Step-by-step from description}
3. Expected: {expected behavior}
4. Actual: {actual behavior}

### Investigation checklist
- [ ] Reproduce the bug on live site
- [ ] Check if it affects multiple viewports ({viewports from config})
- [ ] Check if it affects multiple locales (if applicable)
- [ ] Identify the page/component where the bug occurs
- [ ] Check if similar bugs exist in the backlog
- [ ] Determine severity: cosmetic / functional / blocking

### Possible outcomes
- **Fix it**: Create a minimal code change (developer needed)
- **Escalate**: Assign to the right team with context
- **Close**: Cannot reproduce with documented evidence
- **Defer**: Confirmed but low priority, add context for later
```

### 9. Output Session Briefing

Present the complete briefing and wait for the user to direct next steps. Do NOT start investigating automatically. The user decides what to do.

```
Session ready: {TICKET-ID} — {title}
Branch: fix/{TICKET-ID}-{slug} (if created)
{count} related lessons loaded from memory.

What would you like to do?
- "Reproduce it" — I'll check the live site
- "Investigate" — I'll trace through the codebase
- "Just context" — I've shown you everything, take it from here
```

## Session Discipline

**CRITICAL RULES:**
- ONE ticket per session. No scope creep.
- If you find a second bug while investigating, log it but don't fix it.
- If the fix seems too large (10+ lines), pause and re-evaluate approach.
- Always propose a fix before writing code. Wait for approval.
- End every session with `/shepherd-learn`.
