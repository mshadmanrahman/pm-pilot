---
name: prd
description: |
  Write product requirements documents at variable depth: one-pager, brief, full PRD, or RFC. Auto-detects depth from context. Reads existing research and context if available. Triggers on: "write a PRD", "product spec", "one-pager", "RFC", "requirements doc", "spec for", "brief for".
origin: pm-pilot
version: 1.0.0
---

# PRD: Product Requirements Document

Generate product specs at the right depth for the decision stage. From a quick one-pager to a full PRD to a technical RFC.

## When to Activate

- User says "write a PRD", "product spec", "one-pager for X", "RFC for X"
- User asks for requirements, a spec, or a brief for a feature
- User says "spec this out" or "document the requirements"

## Depth Modes

Auto-detect from user phrasing. If ambiguous, ask.

| Mode | When | Length | Contains |
|------|------|--------|----------|
| **One-pager** | Early exploration, exec alignment | 1 page | Problem, hypothesis, success criteria, key risks |
| **Brief** | Ready to start design/discovery | 2-3 pages | Above + user stories, scope (in/out), dependencies |
| **Full PRD** | Ready to build | 4-8 pages | Above + detailed requirements, edge cases, metrics, rollout plan, open questions |
| **RFC** | Technical decision needed | 2-5 pages | Context, proposal, alternatives considered, tradeoffs, migration plan |

### Detection heuristics
- "quick spec", "one-pager", "executive summary" → One-pager
- "brief", "enough to start building", "design brief" → Brief
- "PRD", "full spec", "detailed requirements" → Full PRD
- "RFC", "tech spec", "architecture decision", "should we migrate" → RFC

## Process

### Step 1: Gather Context

Before writing, check for existing context:

1. **Check for market-research output**: If competitive analysis exists for this domain, reference it
2. **Check memory**: Look for project context, stakeholder preferences, prior decisions
3. **Ask the user** (if context is thin):
   - What problem does this solve?
   - Who is it for?
   - What does success look like?
   - What constraints exist (timeline, team, tech)?

Do not block on missing context. Use what exists, flag what is assumed.

### Step 2: Draft

Write the document at the detected depth level, following the templates below.

Tag uncertain claims:
- `[Assumption]` for things you inferred but the user didn't confirm
- `[Needs data]` for metrics or claims that need validation
- `[Open question]` for decisions that need stakeholder input

### Step 3: Review and Cross-Reference

After drafting, suggest next steps:
- "Run `prioritize` to score this against your backlog"
- "Use `lenny-podcast` for discovery frameworks (Opportunity Solution Trees, JTBD)"
- "Run `market-research` if you need competitive context"
- "Use `critique` to pressure-test this doc" (if critique skill exists)

## Templates

### One-Pager

```markdown
# {Feature Name}: One-Pager

**Status:** Draft
**Author:** {name}
**Date:** {date}

## Problem
{1-2 paragraphs: who has this problem, how painful is it, what evidence exists}

## Hypothesis
If we {solution}, then {outcome}, because {reasoning}.

## Success Criteria
- {Metric 1}: {target}
- {Metric 2}: {target}

## Key Risks
1. {Risk}: {mitigation}
2. {Risk}: {mitigation}

## Open Questions
- {Question that needs answering before committing}
```

### Brief

```markdown
# {Feature Name}: Brief

**Status:** Draft
**Author:** {name}
**Date:** {date}

## Problem
{Problem statement with evidence}

## User Stories
- As a {persona}, I want to {action}, so that {outcome}
- ...

## Proposed Solution
{High-level approach, 2-3 paragraphs}

## Scope
**In scope:**
- {Item}

**Out of scope:**
- {Item} (reason)

## Dependencies
- {Team/system}: {what we need from them}

## Success Criteria
- {Metric}: {target} (measured by {method})

## Timeline
- Discovery: {dates}
- Build: {dates}
- Launch: {date}

## Open Questions
- {Question}
```

### Full PRD

```markdown
# {Feature Name}: PRD

**Status:** Draft
**Author:** {name}
**Date:** {date}
**Stakeholders:** {names}

## Problem Statement
{Detailed problem with user research evidence, data, and business impact}

## Goals and Non-Goals
**Goals:**
- {Goal with measurable outcome}

**Non-Goals:**
- {Explicitly excluded scope}

## User Stories and Requirements

### P0 (Must Have)
| ID | Story | Acceptance Criteria |
|----|-------|-------------------|
| R1 | As a {persona}... | Given/When/Then |

### P1 (Should Have)
| ID | Story | Acceptance Criteria |
|----|-------|-------------------|

### P2 (Nice to Have)
| ID | Story | Acceptance Criteria |
|----|-------|-------------------|

## Design

### User Flow
{Step-by-step flow or link to design file}

### Edge Cases
- {Scenario}: {Expected behavior}

### Error States
- {Error}: {How the user recovers}

## Technical Considerations
- {Architecture implications}
- {Data model changes}
- {API changes}
- {Performance requirements}

## Metrics and Analytics
| Metric | Baseline | Target | Measurement |
|--------|----------|--------|-------------|
| {KPI} | {current} | {goal} | {how tracked} |

## Rollout Plan
1. {Phase 1}: {scope, audience, duration}
2. {Phase 2}: {scope, audience, duration}
3. {GA}: {criteria for full launch}

## Risks and Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| {Risk} | H/M/L | H/M/L | {Plan} |

## Open Questions
- {Question}: {owner, due date}

## Dependencies
- {Team}: {deliverable, timeline}

## Appendix
- {Links to research, designs, prior art}
```

### RFC

```markdown
# RFC: {Decision Title}

**Status:** Draft
**Author:** {name}
**Date:** {date}
**Decision needed by:** {date}

## Context
{Why this decision matters now. What changed or what is broken.}

## Proposal
{The recommended approach, explained clearly enough for someone outside the team.}

## Alternatives Considered

### Option A: {Name}
- **Pros:** {list}
- **Cons:** {list}
- **Effort:** {estimate}

### Option B: {Name} (recommended)
- **Pros:** {list}
- **Cons:** {list}
- **Effort:** {estimate}

### Option C: Do Nothing
- **Pros:** No effort
- **Cons:** {what gets worse}

## Tradeoffs
{The key tension in this decision. What are we optimizing for? What are we giving up?}

## Migration Plan
1. {Step with timeline}
2. {Step with timeline}
3. {Rollback plan if it fails}

## Open Questions
- {Question}
```

## Rules

- Always tag uncertain claims with `[Assumption]`, `[Needs data]`, or `[Open question]`
- Never fabricate metrics, user quotes, or data. Use placeholders if real data is not available.
- Match depth to stage. Do not write a full PRD when a one-pager is sufficient.
- Include "Out of scope" explicitly. The most common PRD failure is unbounded scope.
- Prefer concrete acceptance criteria over vague descriptions.
- If the user provides raw notes or a braindump, extract structure from it rather than asking them to reformat.
