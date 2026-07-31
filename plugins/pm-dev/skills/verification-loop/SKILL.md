---
name: verification-loop
description: Pre-commit verification with lint, type-check, tests, and security scan
origin: pm-pilot
version: 1.0.0
triggers:
  - verify
  - before commits
  - before PRs
  - pre-commit check
---

# Verification Loop

Run all quality gates before committing or creating a PR.

## When to Use

- Before any git commit
- Before creating a pull request
- After completing implementation (before marking done)
- When asked to "verify" or "check everything"

## Procedure

### Step 1: Detect Project Type

Identify available tools from project files:
- `package.json`: npm/yarn scripts (lint, typecheck, test)
- `pyproject.toml` / `setup.py`: Python tooling (ruff, mypy, pytest)
- `go.mod`: Go tooling (golangci-lint, go vet, go test)
- `Cargo.toml`: Rust tooling (clippy, cargo test)

### Step 2: Run Quality Gates

Execute in order (stop on CRITICAL):

| Gate | Command (detect per project) | Severity |
|------|------------------------------|----------|
| Lint | eslint, ruff, golangci-lint | HIGH |
| Type Check | tsc --noEmit, mypy, go vet | HIGH |
| Tests | jest, pytest, go test | CRITICAL |
| Security | npm audit, pip-audit, cargo audit | CRITICAL |
| Coverage | jest --coverage, pytest --cov | HIGH |

### Step 3: Report Results

```
Verification: {project name}

  Lint:       PASS | FAIL ({count} issues)
  Types:      PASS | FAIL ({count} errors)
  Tests:      PASS | FAIL ({pass}/{total})
  Security:   PASS | FAIL ({count} vulnerabilities)
  Coverage:   {percent}% (target: 80%)

Verdict: READY TO COMMIT | BLOCKED ({reason})
```

### Step 4: Actionable Fixes

For each failure, provide:
```
{gate} FAIL:
  {file}:{line} - {error message}
  Fix: {specific suggestion}
```

## Blocking Rules

- CRITICAL failures block commit (tests failing, known vulnerabilities)
- HIGH failures: warn but allow commit with acknowledgment
- MEDIUM/LOW: report only, do not block

## Output Format

```
Verification: lead-scoring-simulator

  Lint:       PASS
  Types:      PASS
  Tests:      PASS (24/24)
  Security:   PASS
  Coverage:   87% (target: 80%)

Verdict: READY TO COMMIT
```

## Rules

- Always run tests with verbose output
- Kill any hung processes after 120s timeout
- If a gate tool is not installed, skip it with a warning
- Never auto-fix lint issues without showing what changed
- Clean up test artifacts after run
