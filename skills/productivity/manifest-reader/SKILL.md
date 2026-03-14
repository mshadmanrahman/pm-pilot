---
name: manifest-reader
description: Read and summarize sub-agent manifest files
origin: pm-pilot
version: 1.0.0
triggers:
  - what did agents find
  - manifest
  - session recap
---

# Manifest Reader

Aggregate and summarize results from sub-agent manifest files.

## When to Use

- After orchestrator completes a wave
- Reviewing results from parallel agent runs
- Session recap to see what was accomplished
- Debugging why a sub-agent produced unexpected results

## Procedure

1. **Locate Manifests**
   - Read all files in `.claude/manifests/`
   - Sort by modification time (newest first)
   - Filter by session or task prefix if specified

2. **Parse Each Manifest**
   Extract from frontmatter:
   - `task`: what was assigned
   - `status`: complete, failed, partial
   - `agent`: which agent ran it

   Extract from body:
   - Key findings
   - Errors encountered
   - Files created or modified

3. **Aggregate**
   - Count: total, complete, failed, partial
   - Group findings by theme or category
   - Collect all errors into a single list

4. **Summarize**
   Output concise report:
   ```
   Manifests: {count} found
   Status: {complete}/{total} complete, {failed} failed

   Key Findings:
   - {finding 1}
   - {finding 2}

   Errors:
   - {error 1 or "none"}

   Files Modified:
   - {path list}
   ```

## Output Format

```
Manifests: 5 found
Status: 4/5 complete, 1 failed

Key Findings:
- Auth module has 3 unpatched vulnerabilities
- API coverage at 72%, below 80% target
- Database queries optimized (avg 40ms reduction)

Errors:
- security-scan: timeout after 120s on legacy module

Files Modified:
- src/api/users.ts
- src/db/queries.ts
```

## Rules

- Read all manifests before summarizing (do not stream partial results)
- Highlight failures prominently
- Keep summary under 20 lines
- If no manifests found, say so clearly
- Do not delete manifests; the orchestrator handles cleanup
