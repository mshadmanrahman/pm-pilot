---
name: lenny-podcast
description: |
  Access PM podcast transcripts (269+ episodes). Search by topic, guest, or concept. Extract quotes and actionable advice. Triggers on: "what does Lenny say about", "find episodes about", "PM advice on".
origin: pm-pilot
version: 1.0.0
---

# Lenny Podcast

Search and extract insights from Lenny's Podcast transcripts (269+ episodes covering product management, growth, leadership, and startups). Find relevant episodes, pull direct quotes, and synthesize actionable advice.

## When to Activate

- User says "what does Lenny say about X", "Lenny podcast on X"
- User says "find episodes about X", "PM advice on X"
- User asks for product management frameworks, guest recommendations, or best practices
- User references a specific guest or episode

## Input

Required:
- **Query**: A topic, concept, guest name, or question

Optional:
- **Limit**: Number of episodes to return (default: 5)
- **Format**: "quotes" (direct quotes), "summary" (synthesized advice), "episodes" (episode list)

## Execution

### Step 1: Expand Search Terms

Generate 3-5 related search terms for the query. PM topics often have multiple framings:
- "pricing" also: "monetization", "willingness to pay", "freemium", "paywall"
- "hiring" also: "recruiting", "interview process", "talent", "team building"
- "metrics" also: "KPIs", "north star metric", "analytics", "measurement"

### Step 2: Search Transcripts

Search the transcript corpus using expanded terms. Rank results by:
1. Direct relevance to the query
2. Specificity of the advice (actionable > theoretical)
3. Authority of the guest on this topic
4. Recency (newer episodes may have updated thinking)

### Step 3: Extract and Synthesize

For each relevant episode:
1. Identify the most relevant segments (2-3 per episode)
2. Pull direct quotes (attribute to speaker)
3. Note the episode number, title, and guest

### Step 4: Format Output

## Output Format

### Default (Summary + Quotes)

```markdown
# What Lenny's Podcast Says About: {Topic}

## Key Takeaways
1. {Synthesized insight} ({Guest Name}, Ep. {number})
2. {Synthesized insight} ({Guest Name}, Ep. {number})
3. {Synthesized insight} ({Guest Name}, Ep. {number})

## Best Quotes

> "{Direct quote}"
> -- {Guest Name}, "{Episode Title}" (Ep. {number})

> "{Direct quote}"
> -- {Guest Name}, "{Episode Title}" (Ep. {number})

## Relevant Episodes
| # | Title | Guest | Why Relevant |
|:--|:------|:------|:-------------|
| {num} | {title} | {guest} | {1-line reason} |

## Frameworks Mentioned
- **{Framework name}** ({Guest}): {1-sentence description}
```

### Episode List Format

```markdown
## Episodes About: {Topic}
| # | Title | Guest | Date |
|:--|:------|:------|:-----|
| {num} | {title} | {guest} | {date} |
```

## Rules

- **Direct quotes only**: Never fabricate quotes. If you cannot find an exact quote, paraphrase and mark it as such.
- **Attribute everything**: Every insight links to a specific guest and episode.
- **Actionable over theoretical**: Prioritize concrete advice, frameworks, and examples over abstract discussion.
- **Diverse perspectives**: When multiple guests discuss the same topic, include different viewpoints.
- **Note disagreements**: If guests contradict each other, surface both positions.

## Common Topics Covered

For reference, these topics have extensive coverage across episodes:
- Product-market fit, growth loops, retention
- Pricing and monetization strategies
- Hiring PMs, engineering managers, designers
- OKRs, metrics, north star metrics
- User research, customer discovery
- B2B vs B2C product management
- AI/ML product management
- Leadership and management transitions
- Startup strategy and fundraising

## Fallback

If transcripts are not available or searchable:
1. Use web search to find episode summaries and show notes.
2. Search for guest interviews and talks on the same topic.
3. Note that results are from secondary sources, not direct transcripts.
