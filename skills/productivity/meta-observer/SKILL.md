---
name: meta-observer
description: Track skill performance and emerging patterns
origin: pm-pilot
version: 1.0.0
triggers:
  - observe skills
  - skill performance
  - passive (runs in background)
---

# Meta Observer

Track which skills are used, how well they work, and what patterns emerge.

## When to Use

- Explicitly: "observe skills", "skill performance"
- Passively: after any session with 3+ skill invocations
- Periodically: weekly review of skill usage

## What to Track

For each skill invocation:
- **Skill name**: which skill was triggered
- **Trigger**: what phrase or condition activated it
- **Outcome**: success, partial, failed
- **Corrections**: did the user correct the output
- **Duration**: rough time spent (fast/medium/slow)

## Procedure

1. **Log Observation**
   Append to `.claude/logs/skill-observations.md`:
   ```markdown
   ## {date}

   | Skill | Trigger | Outcome | Corrections | Notes |
   |-------|---------|---------|-------------|-------|
   | {name} | {trigger} | {outcome} | {yes/no} | {brief note} |
   ```

2. **Detect Patterns**
   After logging, scan for:
   - Skills never used (candidates for removal)
   - Skills frequently corrected (need refinement)
   - Missing skills (user repeatedly does something manually)
   - Trigger mismatches (wrong skill activates)

3. **Surface Insights**
   When patterns emerge:
   ```
   Skill Observations:
   - {skill} triggered {count} times, corrected {count} times
   - Pattern: {description of recurring issue}
   - Suggestion: {improvement recommendation}
   ```

4. **Update Lessons**
   Write significant findings to `tasks/lessons.md`:
   - Skill gaps discovered
   - Trigger improvements needed
   - Workflow optimizations found

## Output Format

```
Skill Observations (last 7 days):
  Most used: orchestrator (8x), tdd-workflow (5x)
  Corrected: handoff-doc (2x) - missing file paths
  Unused: meta-observer, strategic-compact
  Pattern: Users trigger "verify" but mean "tdd-workflow"
  Suggestion: Add "verify" as tdd-workflow trigger
```

## Rules

- Never block workflow to observe; logging is lightweight
- Keep observation log append-only (never delete entries)
- Surface insights only when explicitly asked or patterns are strong
- Create `.claude/logs/` directory if it does not exist
- Observations are internal; never include in external docs
