# PM Pilot

Product management toolkit for Claude Code. Designed for PMs who code.

## Skill Loading
Load skills on demand by trigger, not at session start. Categories:
- **PM Core**: meeting-prep, weekly-status, deep-context, market-sizing, ask-company, dogfood
- **Productivity**: session-init, handoff-doc, strategic-compact, orchestrator
- **Dev**: tdd-workflow, verification-loop, search-first, security-review
- **Content**: market-research, writing-style, writing-substack

## Session Protocol
1. **Start**: Memory is auto-loaded. Say what you're working on. If resuming: read latest handoff.
2. **During**: Save corrections to memory. Use handoff-doc for mid-task context capture.
3. **End**: Create handoff if work is in-progress. Save reusable learnings to memory.

## Agent Dispatch
| Need | Agent |
|------|-------|
| Plan a feature | planner |
| Review code | code-reviewer |
| Fix build errors | build-error-resolver |
| Write tests first | tdd-guide |
| Analyze large files | file-analyzer |

## Principles
- Simplicity first. No over-engineering.
- Immutable data patterns. No mutation.
- TDD for all new code. 80%+ coverage.
- Research before coding. Check existing solutions first.
- Memory compounds. Every session should leave the system smarter.
