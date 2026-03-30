# PM Pilot

Product management toolkit. Designed for PMs who code. Works in Claude Code, Cursor, and Codex.

## Skill Loading
Load skills on demand by trigger, not at session start. Categories:
- **PM Core**: meeting-prep, weekly-status, deep-context, market-sizing, ask-company, dogfood, lenny-podcast, prd, prioritize
- **Productivity**: session-init, handoff-doc, strategic-compact, orchestrator, manifest-reader, meta-observer
- **Dev**: tdd-workflow, verification-loop, search-first, security-review
- **Content**: market-research, writing-style, writing-substack

## Session Protocol
1. **Start**: Memory is auto-loaded. Say what you're working on. If resuming: read latest handoff.
2. **During**: Save corrections to memory. Use handoff-doc for mid-task context capture.
3. **End**: Create handoff if work is in-progress. Save reusable learnings to memory.

## Context Files
If these files exist, skills should read them before producing output:
- `context/company.md` - Company info, goals, constraints
- `context/product.md` - Product state, value prop, differentiators
- `context/competitors.md` - Competitive landscape
- `context/personas.md` - Target user profiles

After producing output, offer to update relevant context files with new knowledge.

## Evidence Tagging
All output documents must tag uncertain claims:
- `[Assumption]` - Inferred, not confirmed by user
- `[Needs data]` - Requires validation with real metrics
- `[Source: X]` - Derived from a specific source
- `[Open question]` - Needs stakeholder input

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
- Context grows through use. Skills read and write back to context files.
