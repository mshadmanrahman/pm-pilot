---
name: orchestrator
description: Wave-based parallel task execution with sub-agents
origin: pm-pilot
version: 1.0.0
triggers:
  - orchestrate
  - run waves
  - parallel execute
---

# Orchestrator

Decompose complex work into independent waves of parallel sub-agent tasks.

## When to Use

- Tasks with 3+ independent sub-tasks
- Research across multiple sources
- Bulk operations (triage, analysis, review)
- Any work where parallelism saves time

## Procedure

1. **Decompose Work**
   - Break task into atomic, independent units
   - Group into waves (units within a wave have zero dependencies)
   - Order waves by dependency: wave 2 depends on wave 1 results

2. **Plan Waves**
   ```
   Wave 1 (parallel): [task-a, task-b, task-c]
   Wave 2 (parallel, depends on wave 1): [task-d, task-e]
   Wave 3 (sequential): [merge results]
   ```

3. **Launch Sub-Agents**
   - One Task agent per wave item
   - Each agent gets: clear objective, input data, output format
   - Each agent writes results to `.claude/manifests/{task-id}.md`

4. **Collect Results**
   - Wait for all agents in a wave to complete
   - Read manifests using `manifest-reader` skill
   - Check for failures or partial results

5. **Merge and Synthesize**
   - Combine results from all waves
   - Resolve conflicts or inconsistencies
   - Produce unified output

## Wave Design Rules

- Max 5 agents per wave (resource constraint)
- Each agent should complete in under 2 minutes
- If an agent fails, note failure and continue (don't block the wave)
- Always have a merge step as the final wave

## Manifest Format

Each sub-agent writes:
```markdown
---
task: {task-id}
status: complete | failed | partial
agent: {agent-description}
---

## Findings
{results}

## Errors
{any errors encountered}
```

## Output Format

```
Orchestration: {task name}
Waves: {count}
Results: {success count}/{total count} tasks completed
Summary: {merged findings}
Failures: {list or "none"}
```

## Rules

- Never launch wave 2 before wave 1 completes
- Always check manifests before proceeding
- Failed agents should not block successful ones
- Keep each agent's scope small and focused
- Clean up manifest files after final merge
