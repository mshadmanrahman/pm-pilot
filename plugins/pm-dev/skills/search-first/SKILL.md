---
name: search-first
description: Research existing solutions before writing custom code
origin: pm-pilot
version: 1.0.0
triggers:
  - before implementing anything new
  - search first
  - find existing solution
---

# Search First

Mandatory research before writing any new code. Reuse beats reinvention.

## When to Use

- Before implementing any new feature
- Before writing a utility function
- Before adding a new dependency
- Before building infrastructure (CI, deploy, tooling)

## Procedure

### Step 1: GitHub Code Search

```bash
# Search for existing implementations
gh search repos "{feature keywords}" --limit 5
gh search code "{function signature or pattern}" --limit 10
```

Look for:
- Battle-tested implementations with stars and activity
- Patterns that solve 80%+ of the problem
- Forkable/portable code with compatible licenses

### Step 2: Package Registry Search

Check the relevant registry:
- **npm**: `npm search {keywords}`
- **PyPI**: `pip index versions {package}` or web search
- **crates.io**: `cargo search {keywords}`
- **Go**: `pkg.go.dev` search

Evaluate packages on:
- Download count and trend
- Last publish date (stale = risk)
- Dependency count (fewer = better)
- License compatibility

### Step 3: Library Documentation

- Read official docs for candidate libraries
- Check API matches the use case
- Verify version compatibility with project

### Step 4: Decision

Output one of:
```
REUSE: {package/repo} - {why it fits}
ADAPT: {package/repo} - {what needs modification}
BUILD: No suitable existing solution - {why}
```

## Output Format

```
Search: {what was needed}

GitHub: 3 repos found, 1 strong match
  - github.com/user/repo (2.1k stars, MIT, active)

Registry: 2 packages evaluated
  - package-name (50k weekly downloads, v3.2.1)

Decision: REUSE package-name
Rationale: Covers all requirements, well-maintained, MIT license
Install: npm install package-name
```

## Rules

- NEVER skip this step for non-trivial implementations
- Spending 5 minutes searching saves hours of coding
- A 90% solution from a library beats a 100% custom solution
- If BUILD is the decision, document why alternatives were rejected
- For trivial utilities (< 10 lines), skip registry search
- Always check license compatibility before adopting
