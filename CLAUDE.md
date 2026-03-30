# PM Pilot

Product management toolkit for Claude Code. Designed for PMs who code.

## Skill Loading
Load skills on demand by trigger, not at session start. Categories:
- **PM Core**: meeting-prep, weekly-status, deep-context, market-sizing, ask-company, dogfood, lenny-podcast, prd, prioritize, synthesize-interviews, critique
- **Productivity**: session-init, handoff-doc, strategic-compact, orchestrator, manifest-reader, meta-observer
- **Dev**: tdd-workflow, verification-loop, search-first, security-review
- **Content**: market-research, writing-style, writing-substack

## Context Flywheel
Four persistent files grow through use. Skills read from them before producing output and offer to update them after.
- `context/company.md` - Company info, goals, constraints
- `context/product.md` - Product state, value prop, differentiators
- `context/competitors.md` - Competitive landscape
- `context/personas.md` - Target user profiles

Rules:
- Never overwrite context. Append or update with `[Updated: YYYY-MM-DD] Previously X, now Y.`
- Tag conversation-sourced inputs with `[Source: PM input, not yet in context files]`
- After saving to context, the tag is no longer needed.
- Context files ship empty. They grow through use.
- If context is missing, ask the user. Do not fabricate.

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

## Evidence Tagging
All output documents must tag uncertain claims:
- `[Assumption]` - Inferred, not confirmed by user
- `[Needs data]` - Requires validation with real metrics
- `[Source: X]` - Derived from a specific source
- `[Open question]` - Needs stakeholder input

## Principles
- Simplicity first. No over-engineering.
- Immutable data patterns. No mutation.
- TDD for all new code. 80%+ coverage.
- Research before coding. Check existing solutions first.
- Memory compounds. Every session should leave the system smarter.
