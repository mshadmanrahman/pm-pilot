# Session Handoff: 2026-03-14

## What Was Worked On
Implemented user authentication flow for the internal dashboard. Added login page, JWT token handling, and protected route middleware.

## Decisions Made
1. **JWT over session cookies**: Chose JWT for stateless auth. The dashboard is API-heavy and scales better without server-side sessions.
2. **Refresh token rotation**: Implemented rotating refresh tokens stored in httpOnly cookies. Access tokens are 15min, refresh tokens are 7 days.
3. **No social login (yet)**: Deferred OAuth providers to phase 2. Email/password covers the internal user base for now.

## Blockers
1. **SMTP config missing**: Cannot test email verification flow. Need SMTP credentials added to Doppler.
2. **Rate limiter dependency**: `express-rate-limit` v7 has a breaking change with our Redis adapter. Pinned to v6.11 for now; needs proper fix.

## Next Steps
1. Add SMTP credentials to Doppler and test email verification end-to-end
2. Write integration tests for login/logout/refresh flows (currently at 62% coverage, need 80%)
3. Implement password reset flow (design spec in Figma, link in ticket INS-2401)
4. Resolve `express-rate-limit` v7 compatibility (see GitHub issue #47)
