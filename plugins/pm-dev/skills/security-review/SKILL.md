---
name: security-review
description: Security checklist for code changes with severity classification
origin: pm-pilot
version: 1.0.0
triggers:
  - after writing code with auth
  - after writing code with user input
  - after writing API endpoints
  - after handling secrets
  - security review
---

# Security Review

Systematic security checklist for code changes. Catch vulnerabilities before they ship.

## When to Use

- After writing authentication or authorization code
- After handling user input (forms, query params, file uploads)
- After creating or modifying API endpoints
- After touching secrets, tokens, or credentials
- Before any commit that touches security-sensitive code

## Procedure

### Step 1: Identify Scope

Determine which checks apply based on changed files:
- Auth code: full checklist
- API endpoints: input validation, injection, rate limiting
- Frontend: XSS, CSRF
- Config/infra: secrets, permissions

### Step 2: Run Checklist

| Check | Severity | What to Look For |
|-------|----------|------------------|
| Hardcoded secrets | CRITICAL | API keys, passwords, tokens in source |
| SQL injection | CRITICAL | String concatenation in queries |
| Auth bypass | CRITICAL | Missing auth checks on protected routes |
| XSS | HIGH | Unsanitized user input in HTML output |
| CSRF | HIGH | Missing CSRF tokens on state-changing requests |
| Input validation | HIGH | Unvalidated user input passed to logic |
| Rate limiting | MEDIUM | Endpoints without rate limits |
| Error leaks | MEDIUM | Stack traces or internal details in responses |
| Authz checks | HIGH | Missing permission verification |
| Dependency vulns | MEDIUM | Known CVEs in dependencies |

### Step 3: Scan Code

```bash
# Check for hardcoded secrets (patterns)
grep -rn "password\s*=\s*['\"]" --include="*.{ts,js,py,go}" .
grep -rn "api_key\s*=\s*['\"]" --include="*.{ts,js,py,go}" .
grep -rn "secret\s*=\s*['\"]" --include="*.{ts,js,py,go}" .

# Check for SQL string concatenation
grep -rn "SELECT.*+.*FROM\|INSERT.*+.*INTO" --include="*.{ts,js,py,go}" .

# Check dependency audit
npm audit 2>/dev/null || pip-audit 2>/dev/null || true
```

### Step 4: Report

```
Security Review: {scope description}

CRITICAL:
- {finding with file:line and fix}

HIGH:
- {finding with file:line and fix}

MEDIUM:
- {finding or "none"}

LOW:
- {finding or "none"}

Verdict: PASS | BLOCKED ({count} CRITICAL issues)
```

## Blocking Rules

- CRITICAL: Must fix before commit. No exceptions.
- HIGH: Must fix before PR merge. Document if deferring.
- MEDIUM: Fix when possible. Track in backlog if deferring.
- LOW: Informational. Fix at convenience.

## Output Format

```
Security Review: User authentication endpoints

CRITICAL: none
HIGH:
- src/api/login.ts:42 - Missing rate limiting on login endpoint
  Fix: Add express-rate-limit middleware (max 5 attempts/min)
MEDIUM:
- src/api/profile.ts:18 - Error response includes stack trace
  Fix: Use generic error message in production
LOW: none

Verdict: PASS (0 CRITICAL, 1 HIGH to fix before merge)
```

## Rules

- Run on every commit that touches auth, input, or API code
- CRITICAL findings stop all work until fixed
- If secrets are found in code, rotate them immediately
- Never suppress findings; document accepted risks explicitly
- Check both new code AND existing code in modified files
