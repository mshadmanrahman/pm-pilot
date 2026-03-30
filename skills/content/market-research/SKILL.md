---
name: market-research
description: |
  Competitive analysis and market research with source attribution. Parallel fan-out across web, review sites, and news. Triggers on: "market research", "competitive analysis", "competitor comparison".
origin: pm-pilot
version: 1.0.0
---

# Market Research

Competitive analysis with source attribution.

## Trigger
"market research", "competitive analysis", "competitor comparison"

## Tools
WebSearch, Exa, WebFetch, any available research MCP tools.

## Process

1. **Scope**: Confirm market, competitors, and dimensions to evaluate (pricing, features, positioning, audience).
2. **Research**: Fan out parallel searches:
   - Company websites (pricing pages, feature lists, about pages)
   - Review sites (G2, Capterra, TrustRadius)
   - News and press releases (recent funding, launches, pivots)
   - Social proof (case studies, testimonials, community size)
3. **Synthesize**: Compile into structured output.

## Output Format

```markdown
# Market Research: {topic}

## Market Overview
- Market size and growth trajectory
- Key trends shaping the space
- Buyer segments and their priorities

## Competitor Comparison Matrix

| Dimension | Competitor A | Competitor B | Competitor C | Our Position |
|-----------|-------------|-------------|-------------|-------------|
| Pricing | ... | ... | ... | ... |
| Key Features | ... | ... | ... | ... |
| Target Audience | ... | ... | ... | ... |
| Strengths | ... | ... | ... | ... |
| Weaknesses | ... | ... | ... | ... |

## Key Findings
1. {Insight with implication}
2. {Insight with implication}
3. {Insight with implication}

## Opportunities
- {Gap we can exploit}
- {Underserved segment}

## Sources
- [Source title](url) - accessed {date}
- [Source title](url) - accessed {date}
```

## Rules
- Every claim must have a cited source. Tag with `[Source: {url or name}]`.
- Distinguish facts from inference. Tag speculation with `[Assumption]`.
- Tag metrics without verification with `[Needs data]`.
- Prefer primary sources (company sites, SEC filings) over secondary (blog posts, tweets).
- Date all findings; markets shift fast.
- If data is unavailable, say so. Never fabricate.
