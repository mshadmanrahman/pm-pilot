---
name: shepherd-learn
description: Record why a triage verdict was wrong so future runs improve, building a learning log over time. Use after discovering a misclassified bug.
---

# /shepherd-learn — Capture Session Lessons

End-of-session command that captures what you learned into the institutional memory. This is what makes Bug Shepherd smarter over time.

**Audience:** Anyone who just finished a bug session. The lessons are written in plain language, not code.

## Why This Matters

Every bug session teaches something. Without capturing it, you (or your team) will repeat the same mistakes, fall into the same traps, and waste time rediscovering the same patterns. The learning log is Bug Shepherd's institutional memory.

## Workflow

### 1. Review the Session

Analyze what happened in this session:
- Which ticket was investigated? (`{TICKET-ID}`)
- What was the bug?
- What was the root cause?
- How many iterations did the fix take?
- Were there false starts or wrong assumptions?
- Did the reviewer catch anything?
- What was surprising or non-obvious?

### 2. Identify Lessons

Extract lessons in these categories:

**Investigation Lessons:**
- What did you look at first? Was that the right place?
- What assumption was wrong?
- What would you do differently next time?

**Technical Lessons** (even for non-developers):
- What component/feature area was the bug in?
- What made it hard to fix?
- Are there related areas likely to have similar bugs?

**Process Lessons:**
- Did the workflow help or hinder?
- Was context from the tracker sufficient?
- Did institutional memory surface useful past lessons?

**Pattern Lessons:**
- Is this a recurring bug pattern? (e.g., "long text overflows in translated locales")
- Does this bug suggest a systemic issue?
- Should a new safety rule be added to `triage.config.yaml`?

### 3. Check for Repeated Mistakes

Read `.claude/learning-log.md` and check:
- Did this session repeat a mistake documented in a previous entry?
- If yes, flag it clearly:
  ```
  "REPEATED MISTAKE: This is the same pattern as session {date} ({ticket})."
  "The lesson was: {previous lesson}"
  "Suggestion: Add a review check to catch this pattern."
  ```

### 4. Write Learning Log Entry

Append a structured entry to `.claude/learning-log.md`:

```markdown
---

### {TICKET-ID} | {Short description} | {date}

**Bug:** {One-line description}
**Root Cause:** {One-line root cause in plain language}
**Iterations:** {number} (1 = got it right first try)
**Category:** {UI/UX | i18n | Performance | Functionality | Data | Infrastructure}

**Lesson:**
{2-3 sentences capturing the key insight. Written so someone unfamiliar with the codebase can understand.}

**Pattern:**
{Is this part of a broader pattern? What other bugs might look similar?}

**Process Note:**
{Optional: any workflow improvement suggestion}
```

### 5. Update Backlog

Update the bug's status in `.claude/backlog-live.md`:
- If fixed: mark with PR number
- If closed: mark as closed with reason
- If deferred: mark as deferred with context
- If escalated: mark with team/person it was escalated to

### 6. Suggest Process Improvements

Based on the session, proactively suggest improvements:

- New safety rule for `triage.config.yaml`?
- New tech stack rule for reviews?
- New category for `never_auto_cancel`?
- Documentation gap in the bug tracker?

```
Session complete: {TICKET-ID}

Lessons captured in learning-log.md
{count} total entries in learning log

Suggestions:
- {improvement 1, if any}
- {improvement 2, if any}

Run /clear to reset for the next session.
```

## Learning Log Format

The learning log (`.claude/learning-log.md`) follows this format:

```markdown
# Bug Shepherd Learning Log
> Institutional memory for {project.name}
> Read this at the start of every session.

## How to Use This Log
- Scan for entries related to your current bug's category
- Look for patterns that might apply
- If you find yourself repeating a documented mistake, stop and re-read

## Entries

{Entries are appended here in reverse chronological order}
```

## The Compounding Effect

After 10 sessions, the learning log typically reveals:
- 2-3 recurring bug patterns (systemic issues worth fixing at the root)
- 1-2 investigation anti-patterns (assumptions that are consistently wrong)
- 3-5 useful heuristics (shortcuts that save investigation time)
- At least 1 process improvement (a gap in the workflow)

This is the real value of Bug Shepherd: it gets smarter the more you use it.
