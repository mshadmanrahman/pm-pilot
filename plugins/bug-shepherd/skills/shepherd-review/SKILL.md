---
name: shepherd-review
description: Quality gate before a bug fix is pushed. Reviews the diff in an isolated subagent that never saw the investigation, then reports PASS, WARN or BLOCK for a human to act on. Use after a fix is written and before opening a PR.
---

# /shepherd-review — Quality Gate Before Pushing

A mandatory quality check before any bug fix is pushed. Ensures minimal, focused changes with proper evidence.

**Audience:** Developers who fixed a bug and want to verify before creating a PR. Also useful for PMs reviewing a developer's proposed fix.

## Independent review, not self-review

Run the actual review (step 3) in a fresh subagent, launched with the `Agent` tool, not in the session that investigated the bug and wrote the fix. That session already holds the investigation narrative and the reasoning that led to this specific diff. Asking it to also grade the diff means the same context that talked itself into the fix is now checking its own work. The audience note above already assumes a second set of eyes ("a developer... a PM reviewing a developer's fix"); this makes that true even on a solo session where the fixer and the reviewer are the same person.

Give the subagent only:
- the diff (`git diff main...HEAD`)
- the ticket ID and title, not the investigation transcript
- `review.tech_stack_rules`, `review.max_line_diff`, `review.require_evidence` from `.claude/triage.config.yaml`
- `.claude/learning-log.md`, for Check 5

It does not get the conversation that produced the fix. If a change can't be justified from the diff and the ticket alone, that's a real finding, not a gap in the subagent's context: either the diff needs a comment or it wasn't scoped as tightly as the fixer assumed.

## Workflow

### 1. Load Configuration (current session)

Read `.claude/triage.config.yaml` for:
- `review.max_line_diff` — flag if net lines exceed this
- `review.tech_stack_rules` — project-specific checks
- `review.require_evidence` — whether before/after evidence is required

### 2. Verify Active Session (current session)

Check for an active branch (not main/master):
- If on main: "No active fix branch. Run /shepherd-start {TICKET-ID} first."
- Read the ticket ID from the branch name (expects: `fix/{TICKET-ID}-{slug}`)

### 3. Analyze the Diff (isolated subagent)

Run `git diff main...HEAD` to capture the diff, then launch the review in a new `Agent` call with only the four inputs listed above. Do not run Checks 1-5 below in the current session — that skips the isolation this section exists for.

The subagent runs:

#### Check 1: Subtraction Check
Count net lines added vs. removed. If net additions > `review.max_line_diff`:
```
"This fix adds {net} net lines (threshold: {max_line_diff})."
"Bug fixes should ideally subtract code or be minimal. Justify each addition."
```
Verdict: WARN (not blocking, but requires justification)

#### Check 2: Scope Check
List all modified files. For each file:
- Is it directly related to the bug being fixed?
- Is it a shared/common component (used by many features)?

If shared component modified:
```
"Shared component modified: {file}"
"This component is used by {count} other features. Changes here affect more than just this bug."
"Consumers: {list of importing files}"
```
Verdict: WARN

#### Check 3: Project-Specific Rules
Execute each rule in `review.tech_stack_rules`:
```yaml
- name: "Rule name"
  check: "shell command that returns non-empty on violation"
  severity: "block | warn"
  message: "Human-readable explanation"
```
- Run each check command
- If output is non-empty, report the violation
- Verdict: BLOCK or WARN based on severity

#### Check 4: Every-Line Justification
For each changed line in the diff, provide:
- What the line does
- Why it's necessary for THIS bug fix
- What would break if this line were removed

This forces the fixer to articulate why every change matters.

#### Check 5: Learning Log Cross-Reference
Read `.claude/learning-log.md` and check if:
- This fix follows a documented pattern (good)
- This fix contradicts a documented lesson (bad, flag immediately)
- A similar fix was attempted before and required iterations (warn about known pitfalls)

### 4. Run Linting and Type Checks (isolated subagent, same call as step 3)

Detect the project's tooling and run applicable checks on changed files only:
- JavaScript/TypeScript: `npx eslint {files}` and `npx tsc --noEmit`
- Python: `ruff check {files}` or `flake8 {files}`
- Go: `go vet {files}`
- Other: Skip with note

### 5. Generate Verdict (isolated subagent; returns to the current session)

Combine all check results:

**PASS** — All checks clean
```
Review: PASS
  Lines changed: +{added} -{removed} (net: {net})
  Files: {count}
  Warnings: 0
  Ready to push.
```

**WARN** — Non-blocking issues found
```
Review: WARN ({count} warnings)
  {warning 1}
  {warning 2}
  Proceed with caution. Address warnings if possible.
```

**BLOCK** — Blocking issues found
```
Review: BLOCK ({count} blockers)
  {blocker 1}
  {blocker 2}
  Fix blockers before pushing.
```

### 6. Generate PR Description (current session)

The current session holds the investigation narrative the subagent deliberately didn't get, so it writes the PR description, using the subagent's verdict plus its own knowledge of why the bug happened.

If verdict is PASS or WARN, draft the PR description:

```markdown
## {TICKET-ID}: {Bug title}

### Root Cause
{One-paragraph explanation of why the bug existed}

### Fix
{One-paragraph explanation of what was changed and why}

### Testing
- [ ] Reproduced bug on live/staging site
- [ ] Verified fix at {viewport 1}px
- [ ] Verified fix at {viewport 2}px
- [ ] Verified fix at {viewport 3}px
- [ ] Checked adjacent features for regressions
- [ ] Ran linting and type checks

### Evidence
{Before/after screenshots or recordings, if require_evidence is true}
```

### 7. Wait for User Decision

```
Review complete. Verdict: {PASS/WARN/BLOCK}

Options:
- "Push it" — commit, push, and create PR
- "Fix {issue}" — address a specific warning/blocker
- "Show diff" — review the full diff again
```

## Red Flags (Auto-Block)

If any of these are detected, verdict is automatically BLOCK:
- Changing files not related to the ticket
- Adding new dependencies or imports unrelated to the fix
- Refactoring code that isn't broken
- Adding configuration options for a bug fix
- Modifying test files to make them pass (instead of fixing the code)
