---
name: handoff-doc
description: Create portable handoff document when switching sessions
origin: pm-pilot
version: 1.0.0
triggers:
  - handoff
  - save context
  - switching sessions
---

# Handoff Doc

Capture session state into a portable document for future sessions or other agents.

## When to Use

- Ending a work session
- Switching to a different task or project
- Before context compaction
- Handing work to another person or agent

## Procedure

1. **Gather Context**
   - Review git log for commits made this session
   - Review files modified (`git diff --name-only` against session start)
   - Review any task updates in `tasks/todo.md`
   - Review any lesson entries added to `tasks/lessons.md`

2. **Build Handoff Document**
   Write to `.claude/handoffs/YYYY-MM-DD-session.md`:

   ```markdown
   ---
   date: {ISO 8601}
   project: {project name}
   ---

   # Session Handoff

   ## What Was Worked On
   - {bullet list of tasks/features touched}

   ## Decisions Made
   - {key decisions with rationale}

   ## Files Modified
   - {path}: {what changed}

   ## Open Questions
   - {unresolved questions}

   ## Blockers
   - {anything preventing progress, or "None"}

   ## Next Steps
   1. {exact next action}
   2. {follow-up action}
   ```

3. **Update Memory**
   - Add or update relevant entry in `MEMORY.md` if significant project state changed

4. **Confirm**
   - Output path to handoff file
   - Output one-line summary of session

## Output Format

```
Handoff saved: .claude/handoffs/2026-03-14-session.md
Summary: Implemented CPL calculation, 2 open questions on data source.
```

## Rules

- Use real datetime from `date -u` command
- Keep each section to 3-5 bullets max
- File paths must be relative (per path-standards rule)
- Never include secrets or credentials in handoff docs
- If multiple handoffs same day, append `-2`, `-3` suffix
