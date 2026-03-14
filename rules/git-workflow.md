# Git Workflow

## Commit Format
```
<type>: <description>

<optional body>
```
Types: feat, fix, refactor, docs, test, chore, perf, ci

## PR Workflow
1. Analyze full commit history (not just latest commit)
2. Use `git diff [base-branch]...HEAD` for all changes
3. Draft comprehensive PR summary
4. Include test plan with TODOs
5. Push with `-u` flag for new branches

## Branch Naming
- Features: `feat/short-description`
- Fixes: `fix/short-description`
- Epics: `epic/feature-name`
