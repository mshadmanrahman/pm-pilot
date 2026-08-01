---
name: shepherd-review
description: Review triage results before syncing, so a human confirms verdicts on bugs that will be closed or reprioritized. Use between triage and sync.
---

# /shepherd-review — Quality Gate Before Pushing

A mandatory quality check before any bug fix is pushed. Ensures minimal, focused changes with proper evidence.

**Audience:** Developers who fixed a bug and want to verify before creating a PR. Also useful for PMs reviewing a developer's proposed fix.

## Workflow

### 1. Load Configuration

Read `.claude/triage.config.yaml` for:
- `review.max_line_diff` — flag if net lines exceed this
- `review.tech_stack_rules` — project-specific checks
- `review.require_evidence` — whether before/after evidence is required

### 2. Verify Active Session

Check for an active branch (not main/master):
- If on main: "No active fix branch. Run /shepherd-start {TICKET-ID} first."
- Read the ticket ID from the branch name (expects: `fix/{TICKET-ID}-{slug}`)

### 3. Analyze the Diff

Run `git diff main...HEAD` to see all changes in this branch.

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

### 4. Run Linting and Type Checks (if available)

Detect the project's tooling and run applicable checks on changed files only:
- JavaScript/TypeScript: `npx eslint {files}` and `npx tsc --noEmit`
- Python: `ruff check {files}` or `flake8 {files}`
- Go: `go vet {files}`
- Other: Skip with note

### 5. Generate Verdict

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

### 6. Generate PR Description

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
