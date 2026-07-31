---
name: critique
description: |
  Pressure-test any document for logic gaps, unsupported assumptions, missing perspectives, and completeness. Works on PRDs, briefs, strategy docs, proposals, and any PM artifact. Triggers on: "critique this", "pressure test", "poke holes", "review this doc", "what am I missing", "devil's advocate".
origin: pm-pilot
version: 1.0.0
---

# Critique: Document Pressure Testing

Systematically challenge any document for logic, assumptions, completeness, and blind spots. The goal is to make the document stronger, not to tear it down.

## When to Activate

- User says "critique this", "pressure test", "poke holes in this"
- User says "what am I missing?", "devil's advocate"
- User asks for review of a PRD, brief, strategy doc, or proposal
- Proactively after `prd` skill produces a Full PRD or RFC

## Input

Accept any document: PRD, brief, RFC, strategy doc, proposal, pitch, research synthesis, OKRs.

Accept via paste, file path, or workspace reference.

## Process

### Step 1: Understand Intent

Before critiquing, identify:
1. **Document type**: PRD, RFC, strategy, proposal, etc.
2. **Audience**: Who will read this? (engineers, execs, stakeholders, investors)
3. **Stage**: Early exploration or ready to ship?
4. **Stakes**: Low-risk experiment or bet-the-company decision?

Calibrate critique intensity to stage and stakes. An early one-pager gets lighter scrutiny than a Full PRD about to be shipped.

### Step 2: Evaluate Across 6 Dimensions

| Dimension | What to Check |
|-----------|--------------|
| **Logic** | Does the argument flow? Are conclusions supported by premises? Any circular reasoning? |
| **Assumptions** | What is taken for granted? Which assumptions are validated vs hoped? |
| **Evidence** | Are claims backed by data, research, or citations? Any `[Assumption]` tags unresolved? |
| **Completeness** | What is missing? Stakeholders not consulted? Edge cases ignored? Risks unaddressed? |
| **Feasibility** | Can this actually be built/shipped? Technical constraints? Resource reality? |
| **Alternatives** | Were other approaches considered? Is there a simpler solution? |

### Step 3: Produce Critique

```markdown
# Critique: {Document Title}

**Reviewed:** {date}
**Document stage:** {early/mid/late}
**Overall assessment:** {Strong / Needs work / Major gaps}

## Strengths
- {What is well done and should be preserved}
- {Strong evidence, clear logic, good scoping}

## Issues

### Critical (blocks shipping)
1. **{Issue title}**
   - **Problem:** {What's wrong}
   - **Evidence:** {Where in the doc}
   - **Suggestion:** {How to fix}

### Important (should fix before finalizing)
2. **{Issue title}**
   - **Problem:** {What's wrong}
   - **Suggestion:** {How to fix}

### Minor (nice to fix)
3. **{Issue title}**
   - **Suggestion:** {Quick fix}

## Missing Perspectives
- {Stakeholder or user group not represented}
- {Technical constraint not addressed}
- {Market reality not considered}

## Unvalidated Assumptions
| # | Assumption | Risk if Wrong | How to Validate |
|---|-----------|---------------|-----------------|
| 1 | {assumption} | {consequence} | {experiment or data source} |

## Questions the Document Should Answer
- {Question that a skeptical reader would ask}
- {Question that an engineer would ask}
- {Question that an exec would ask}

## Recommended Next Steps
1. {Most important fix}
2. {Second priority}
3. {Third priority}
```

### Step 4: Cross-Reference

After critique:
- "Use `prd` to revise based on this feedback"
- "Use `synthesize-interviews` if assumptions need user validation"
- "Use `market-research` if competitive claims are unsubstantiated"
- "Use `lenny-podcast` for frameworks on {relevant topic from critique}"

## Critique Calibration

| Document Stage | Critique Intensity | Focus On |
|---------------|-------------------|----------|
| Early exploration | Light | Logic, assumptions, missing alternatives |
| Design/discovery | Medium | Completeness, feasibility, evidence |
| Ready to build | Heavy | All 6 dimensions, edge cases, risks |
| Post-launch review | Reflective | What worked, what didn't, lessons |

## Rules

- **Lead with strengths.** Always acknowledge what's good before what's wrong.
- **Be specific.** "This section is weak" is useless. "The success criteria on line 3 measures output, not outcome" is actionable.
- **Suggest, don't prescribe.** Offer directions, not rewrites. The author makes the call.
- **Calibrate to stage.** Do not demand full evidence for an early brainstorm.
- **Flag your own uncertainty.** If you are unsure whether something is a real issue, say so: `[Possible issue, verify]`.
- **Never be cruel.** The goal is to make the document stronger, not to demonstrate your cleverness. Warmth and directness are not opposites.
