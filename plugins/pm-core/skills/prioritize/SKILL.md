---
name: prioritize
description: |
  Feature and initiative prioritization using 7 frameworks (RICE, ICE, WSJF, MoSCoW, Value/Effort, Kano, Weighted Scoring). Auto-detects mode: stack rank, scoring, opportunity assessment, trade-off analysis, or scope cut. Triggers on: "prioritize", "rank these features", "RICE score", "what should we build next", "scope cut", "trade-off".
origin: pm-pilot
version: 1.0.0
---

# Prioritize: Feature Ranking and Scoring

Score and rank features, initiatives, or backlog items using established PM frameworks. Auto-detects the right framework and mode from context.

## When to Activate

- User says "prioritize", "rank these", "what should we build next?"
- User asks for RICE, ICE, WSJF, or any scoring framework
- User needs to make scope cuts or trade-off decisions
- User has a list of features and needs to decide order

## Modes

Auto-detect from user phrasing. If ambiguous, ask.

| Mode | When | Output |
|------|------|--------|
| **Stack rank** | "What should we build next?" | Ordered list with reasoning |
| **Scoring** | "Score these 10 features" | Framework table with scores |
| **Opportunity assessment** | "Where's the biggest opportunity?" | Gap analysis, underserved areas |
| **Trade-off analysis** | "Should we do A or B?" | Side-by-side comparison |
| **Scope cut** | "We need to cut scope" | Keep/cut/defer recommendations |

### Detection heuristics
- "rank", "order", "what first", "what next" → Stack rank
- "score", "RICE", "ICE", "rate these" → Scoring
- "opportunity", "gap", "underserved" → Opportunity assessment
- "A or B", "trade-off", "which one", "compare" → Trade-off analysis
- "cut scope", "too much", "reduce", "what can we drop" → Scope cut

## Frameworks

### RICE (default for scoring mode)
Best for: Large backlogs, cross-team prioritization, when you need a defensible number.

| Feature | Reach | Impact | Confidence | Effort | RICE Score |
|---------|-------|--------|------------|--------|------------|
| {name} | {users/qtr} | {0.25-3} | {50-100%} | {person-months} | {R×I×C/E} |

- **Reach**: How many users affected per quarter
- **Impact**: 3 = massive, 2 = high, 1 = medium, 0.5 = low, 0.25 = minimal
- **Confidence**: 100% = high certainty, 80% = medium, 50% = low
- **Effort**: Person-months of work

### ICE (default for quick decisions)
Best for: Fast prioritization, smaller teams, when RICE feels heavy.

| Feature | Impact | Confidence | Ease | ICE Score |
|---------|--------|------------|------|-----------|
| {name} | {1-10} | {1-10} | {1-10} | {I×C×E} |

### WSJF (Weighted Shortest Job First)
Best for: SAFe teams, flow-based delivery, when cost of delay matters.

| Feature | User Value | Time Criticality | Risk Reduction | Job Size | WSJF |
|---------|-----------|-------------------|----------------|----------|------|
| {name} | {1-10} | {1-10} | {1-10} | {1-10} | {(UV+TC+RR)/JS} |

### MoSCoW
Best for: Scope negotiation with stakeholders, release planning.

| Priority | Features | Rationale |
|----------|----------|-----------|
| **Must have** | {list} | Without these, the release has no value |
| **Should have** | {list} | Important but not critical for launch |
| **Could have** | {list} | Nice to have, first to cut if time runs short |
| **Won't have** | {list} | Explicitly out of scope for this release |

### Value/Effort Matrix
Best for: Visual communication to stakeholders, quick alignment.

```
        HIGH VALUE
            │
  Quick     │    Big Bets
  Wins ★    │    (plan carefully)
            │
────────────┼────────────
            │
  Fill-ins  │    Money Pit
  (if idle) │    (avoid)
            │
        LOW VALUE
   LOW EFFORT      HIGH EFFORT
```

Categorize each feature into a quadrant with one-line reasoning.

### Kano Model
Best for: Feature categorization, understanding user expectations vs delight.

| Feature | Category | Evidence |
|---------|----------|----------|
| {name} | Must-be / Performance / Attractive / Indifferent / Reverse | {why} |

- **Must-be**: Expected. Absence causes dissatisfaction. Presence does not delight.
- **Performance**: More is better. Linear satisfaction curve.
- **Attractive**: Unexpected delight. Absence does not disappoint.
- **Indifferent**: Users do not care either way.
- **Reverse**: Some users actively dislike this.

### Weighted Scoring
Best for: Custom criteria, when standard frameworks do not fit.

1. Ask user to define 3-5 scoring criteria (e.g., strategic alignment, revenue impact, technical feasibility)
2. Ask for weights (must sum to 100%)
3. Score each feature 1-10 on each criterion
4. Weighted score = sum of (score × weight)

## Process

### Step 1: Gather Items
If the user provides a list, use it. If not, ask:
- What items need prioritizing?
- What is the context? (quarterly planning, scope cut, new initiative)
- Any constraints? (team size, deadline, dependencies)

### Step 2: Select Framework
Auto-select based on mode and context:

| Context | Recommended Framework |
|---------|----------------------|
| "Score these features" (no other context) | RICE |
| "Quick prioritization" | ICE |
| SAFe team, mentions "cost of delay" | WSJF |
| Scope negotiation, release planning | MoSCoW |
| Stakeholder presentation | Value/Effort Matrix |
| Understanding user expectations | Kano |
| Custom criteria mentioned | Weighted Scoring |

If the user asks for a specific framework, use that one.

### Step 3: Score and Rank

For each item:
1. Score against the framework dimensions
2. Show your reasoning for each score (one line)
3. Flag low-confidence scores with `[Assumption]`

### Step 4: Present Results

**Scoring mode**: Framework table + ranked list + recommendation

**Stack rank mode**: Ordered list with one-line reasoning per item

**Scope cut mode**: Keep/Cut/Defer table with impact assessment:
```
| Feature | Decision | Impact of Cutting | Recommendation |
|---------|----------|-------------------|----------------|
| {name}  | Keep/Cut/Defer | {what we lose} | {why} |
```

### Step 5: Cross-Reference

After prioritizing, suggest:
- "Use `prd` to spec the top-ranked item"
- "Run `market-research` to validate assumptions in your scoring"
- "Use `lenny-podcast` for prioritization frameworks (Sean Ellis on ICE, Shreyas Doshi on LNO)"

## Rules

- Always show your reasoning for scores. A number without rationale is useless.
- Flag assumptions explicitly. Scoring with made-up confidence is worse than no scoring.
- Never present a single framework as the "right" answer. Frameworks are lenses, not truth.
- If two items score within 10% of each other, call it a tie and recommend the user make the judgment call.
- For scope cuts, always quantify what is lost by cutting, not just what is saved.
- Prefer fewer, better-scored items over exhaustive lists with thin reasoning.
