---
name: synthesize-interviews
description: |
  Turn raw user interviews, transcripts, and feedback into structured themes, pain points, and recommendations. Produces both a synthesis report and a standalone pain points document. Triggers on: "synthesize interviews", "interview findings", "user research synthesis", "what did users say", "analyze feedback".
origin: pm-pilot
version: 1.0.0
---

# Synthesize Interviews: User Research Synthesis

Turn raw interview transcripts, notes, or feedback dumps into structured insights. Produces two outputs: a synthesis report (themes + recommendations) and a standalone pain points document (problems only, no solutions).

## When to Activate

- User says "synthesize interviews", "what did users say about X"
- User provides interview transcripts or notes to analyze
- User says "analyze this feedback", "research findings"
- After 3+ customer conversations (suggest proactively)

## Input Modes

Accept input three ways:
1. **Pasted content**: Raw transcript or notes directly in conversation
2. **File path**: Point to a file or directory of transcripts
3. **Workspace reference**: "Look at the interview notes in /research"

If input is a single interview, produce per-interview notes. If 3+ interviews, produce a cross-interview synthesis.

## Process

### Step 1: Extract Raw Observations

For each interview/feedback source:
1. Identify the participant (role, context, seniority if available)
2. Extract **direct quotes** that reveal pain, motivation, or behavior
3. Note **behaviors** (what they actually do, not what they say they do)
4. Flag **surprises** (anything that contradicts assumptions)
5. Tag source: `[Interview: {participant}, {date}]`

### Step 2: Identify Themes

Group observations across interviews:
1. Cluster related observations into themes (3-7 themes typical)
2. For each theme, count how many participants mentioned it
3. Rank themes by: frequency (how many said it) x intensity (how strongly they felt it)
4. Distinguish between **stated needs** (what they say) and **observed needs** (what they do)

### Step 3: Generate Pain Points Document

Produce a standalone document of problems only. No solutions. This prevents premature solutioning.

```markdown
# Pain Points: {Research Topic}

**Status:** Draft
**Interviews:** {count}
**Date:** {date}

## Critical Pain Points (mentioned by 60%+ participants)

### 1. {Pain point title}
- **Frequency:** {n}/{total} participants
- **Intensity:** High/Medium/Low
- **Evidence:**
  - "{Direct quote}" - {participant} [Interview: {name}, {date}]
  - "{Direct quote}" - {participant}
- **Current workaround:** {how they cope today}

## Significant Pain Points (mentioned by 30-60%)

### 2. {Pain point title}
...

## Emerging Signals (mentioned by <30% but high intensity)

### 3. {Pain point title}
...
```

### Step 4: Generate Synthesis Report

```markdown
# Research Synthesis: {Topic}

**Status:** Draft
**Interviews:** {count}
**Date:** {date}
**Researcher:** {name}

## Executive Summary
{2-3 sentence summary of the most important finding}

## Methodology
- {count} interviews with {participant profile}
- Conducted {date range}
- Method: {structured/semi-structured/contextual inquiry}

## Key Themes

### Theme 1: {Title} ({n}/{total} participants)
**Summary:** {1-2 sentences}
**Evidence:**
- "{Quote}" - {participant} [Interview: {name}, {date}]
- "{Quote}" - {participant}
**Implication:** {What this means for the product}

### Theme 2: {Title}
...

## Contradictions and Tensions
- {Where participants disagreed and why it matters}

## Surprises
- {Things that challenged our assumptions} [Assumption invalidated]

## Recommendations
1. **{Action}**: {Why, based on which themes}
2. **{Action}**: {Why}
3. **{Action}**: {Why}

## Open Questions
- {What we still don't know after this research}

## Appendix: Participant Summary
| # | Role | Context | Key Quote |
|---|------|---------|-----------|
| P1 | {role} | {context} | "{quote}" |
```

### Step 5: Cross-Reference

After synthesis:
- "Use `prd` to spec solutions for the top pain points"
- "Use `prioritize` to rank which pain points to solve first"
- "Use `lenny-podcast` for Teresa Torres' Opportunity Solution Tree approach"
- Offer to update `context/personas.md` with new insights

## Rules

- **Never fabricate quotes.** Every quote must come from the provided input.
- **Separate observation from interpretation.** Label which is which.
- **Pain points doc has NO solutions.** This is deliberate. Solutions come later.
- **Tag evidence provenance.** Every claim links to a specific participant and source.
- **Preserve contradictions.** If participants disagree, that's data, not noise.
- **Count frequency honestly.** "1 out of 3 mentioned it" is not a pattern. Say so.
- **Flag small sample sizes.** If fewer than 5 interviews, add `[Small sample: {n} interviews. Treat as directional, not conclusive.]`
