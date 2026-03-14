---
name: market-sizing
description: |
  TAM/SAM/SOM market sizing analysis. Uses web search and research tools to produce a structured analysis with data sources, assumptions, calculations, and confidence ranges. Triggers on: "calculate TAM", "size the market", "market opportunity".
origin: pm-pilot
version: 1.0.0
---

# Market Sizing

Produces a structured TAM/SAM/SOM market sizing analysis using web research, industry data, and bottom-up calculations.

## When to Activate

- User says "calculate TAM", "size the market", "market opportunity"
- User asks "how big is the market for X?"
- User needs market sizing for a pitch deck, PRD, or business case

## Input

Required:
- **Product/service description**: What is being sized
- **Target customer**: Who buys this

Optional:
- **Geography**: Default is global
- **Time horizon**: Default is current year + 5-year projection
- **Methodology preference**: top-down, bottom-up, or both (default: both)

## Execution

### Step 1: Define the Market

Clarify with the user if ambiguous:
- What problem is being solved?
- Who are the target customers (segment, size, industry)?
- What is the product/service category?
- What is the geographic scope?

### Step 2: Research (Parallel)

Use web search tools to gather data from multiple sources:

| Data Type | Sources to Search |
|:----------|:-----------------|
| Industry reports | Gartner, Forrester, IDC, Statista, Grand View Research |
| Company data | Public filings, earnings calls, analyst reports |
| Customer data | Census data, industry associations, trade publications |
| Competitive landscape | Crunchbase, PitchBook, competitor pricing pages |
| Growth rates | Historical CAGR, analyst projections |

### Step 3: Calculate TAM (Two Methods)

**Top-Down:**
1. Find total market category size from research reports
2. Document source, year, and methodology
3. Apply growth rate to current year if data is older

**Bottom-Up:**
1. Count total potential customers in target segment
2. Determine average annual revenue per customer (pricing research)
3. TAM = Total Customers x Annual Revenue per Customer

### Step 4: Calculate SAM

Narrow TAM by applying realistic filters:
- Geographic constraints
- Product capability constraints
- Customer segment constraints
- Distribution/channel constraints

SAM = TAM x (% matching all filters)

### Step 5: Calculate SOM

Estimate realistic market capture over 3-5 years:
- New entrant: 2-5% of SAM
- Established player entering adjacent market: 5-10% of SAM
- Account for competitive intensity and switching costs

### Step 6: Validate

Cross-check top-down vs bottom-up (should be within 30%). Flag if they diverge significantly.

## Output Format

```markdown
# Market Sizing: {Product/Service}

## Market Definition
- **Problem:** {problem being solved}
- **Customer:** {target segment}
- **Category:** {market category}
- **Geography:** {scope}

## TAM: {$X.XB}
### Top-Down
- {Source}: {total market size} ({year})
- Growth rate: {X%} CAGR
- **TAM (top-down):** {$amount}

### Bottom-Up
- Total addressable customers: {count} ({source})
- Average annual revenue per customer: {$amount} ({source})
- **TAM (bottom-up):** {$amount}

### Triangulation
{How the two methods compare. Flag if >30% divergence.}

## SAM: {$X.XB}
| Filter | Reduction | Rationale |
|:-------|:----------|:----------|
| {Geographic} | {X%} | {why} |
| {Segment} | {X%} | {why} |
| {Product fit} | {X%} | {why} |
**SAM:** TAM x {combined %} = {$amount}

## SOM: {$X.XM} (Year 3-5)
- Competitive intensity: {high/medium/low}
- Realistic capture rate: {X%}
- **SOM (Year 3):** {$amount}
- **SOM (Year 5):** {$amount}

## Confidence Assessment
- **Data quality:** {high/medium/low} - {why}
- **Key assumptions:** {list the 2-3 most impactful assumptions}
- **Sensitivity:** {what changes if key assumptions shift by 20%}

## Sources
1. {Source with URL or citation}
2. {Source with URL or citation}
```

## Rules

- **Two methods minimum**: Always calculate both top-down and bottom-up.
- **Cite every number**: No unsourced figures. If estimated, say so explicitly.
- **Show your math**: Every calculation should be traceable.
- **Conservative by default**: Use lower bounds when data is ambiguous.
- **Date the data**: Always note the year of each data source.
- **Flag assumptions**: Every non-trivial assumption gets called out.
- **No vanity TAMs**: If the TAM seems unreasonably large, challenge the market definition.
