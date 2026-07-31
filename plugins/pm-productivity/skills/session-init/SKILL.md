---
name: session-init
description: Lightweight session initialization with context recovery
origin: pm-pilot
version: 1.0.0
triggers:
  - resume
  - init
  - pick up where I left off
---

# Session Init

Quick-start a session by loading prior context and surfacing open work.

## When to Use

- Starting a new session
- Returning after a break
- Picking up someone else's work

## Procedure

1. **Load Memory**
   - Read `MEMORY.md` (auto-loaded, but scan for recent entries)
   - Note any `currentDate` or session-specific flags

2. **Check Handoffs**
   - Read latest file in `.claude/handoffs/` (sort by date desc)
   - Extract: last task, decisions, blockers, next steps

3. **Check Open Tasks**
   - Read `tasks/todo.md`
   - Count open vs completed items
   - Identify highest-priority incomplete item

4. **Check Lessons**
   - Scan `tasks/lessons.md` for entries from last 3 sessions
   - Note any recurring patterns or warnings

5. **Output Summary**
   Produce exactly 5 lines:
   ```
   Session: {date}
   Last: {what was last worked on}
   Open: {count} tasks ({top priority item})
   Blockers: {any blockers or "none"}
   Next: {recommended first action}
   ```

## Output Format

```
Session: 2026-03-14
Last: Lead scoring simulator deploy
Open: 3 tasks (fix CPL calculation)
Blockers: none
Next: Run verification loop on simulator changes
```

## Rules

- Never spend more than 30 seconds on init
- If no handoff exists, say so and ask user for context
- Do not auto-start work; present summary and wait for direction
