---
name: strategic-compact
description: Monitor context usage and suggest compaction at logical milestones
origin: pm-pilot
version: 1.0.0
triggers:
  - proactive when context exceeds 60%
  - compact
  - context getting long
---

# Strategic Compact

Proactively manage context window to prevent degraded performance in long sessions.

## When to Use

- Context usage exceeds 60%
- After completing a major planning phase
- After finishing implementation, before review
- Before starting a fundamentally different task
- When responses start feeling slower or less precise

## Procedure

1. **Assess Context State**
   - Estimate current context consumption
   - Identify which content is load-bearing vs stale

2. **Identify Compaction Point**
   Suggest compaction at natural milestones:
   - After planning: decisions locked, plan documented
   - After implementation: code committed, tests passing
   - Before review: implementation complete, shifting to review mode
   - After triage: results documented, moving to fixes

3. **Preserve Key State**
   Before suggesting `/clear`, ensure these are persisted:
   - Active task and status in `tasks/todo.md`
   - Key decisions in handoff doc or `tasks/lessons.md`
   - Any uncommitted work is committed or stashed
   - File paths of actively-edited files

4. **Suggest Compaction**
   Output:
   ```
   Context check: ~{percent}% used
   Milestone: {what was just completed}
   Recommendation: {compact now / safe to continue / approaching limit}

   Before /clear:
   - [ ] Handoff doc written
   - [ ] Work committed
   - [ ] Todo updated
   ```

5. **Post-Compaction Recovery**
   After `/clear`, use `session-init` skill to restore context.

## Output Format

```
Context check: ~65% used
Milestone: Implementation phase complete
Recommendation: Good time to compact before code review

Before /clear:
- [ ] Handoff doc written
- [ ] Work committed (3 files)
- [ ] Todo updated
```

## Rules

- Never force compaction; always suggest
- Never compact mid-task; wait for a milestone
- Always write handoff doc before suggesting /clear
- Err on the side of compacting earlier rather than later
- The last 20% of context window produces degraded output
