# Security

## Pre-Commit Checklist
- [ ] No hardcoded secrets (API keys, passwords, tokens)
- [ ] All user inputs validated
- [ ] Parameterized queries (no SQL injection)
- [ ] Sanitized HTML output (no XSS)
- [ ] CSRF protection enabled
- [ ] Auth/authz verified on all endpoints
- [ ] Rate limiting on all endpoints
- [ ] Error messages leak no sensitive data

## Secret Management
- NEVER hardcode secrets in source code
- Use environment variables or secret manager
- Validate required secrets at startup
- Rotate any exposed secrets immediately

## If Security Issue Found
1. STOP current work
2. Fix CRITICAL issues before continuing
3. Rotate any exposed secrets
4. Review codebase for similar issues
