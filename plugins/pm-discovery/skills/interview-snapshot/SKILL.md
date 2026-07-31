---
name: interview-snapshot
description: Transform a single customer interview transcript into a structured Interview Snapshot with five fixed sections. Use when the user has a Granola/Fireflies/manual transcript and needs the atomic research unit that feeds cross-interview synthesis. Triggers on "create interview snapshot", "process this interview", "synthesize this one interview", "turn this transcript into a snapshot". Prerequisite for any cross-interview synthesis step in discovery-process.
---

# Interview Snapshot

One interview in, one structured markdown file out. Nothing else.

This is the atomic unit of customer research. Before ever running cross-interview synthesis, every interview passes through here first. Teresa Torres calls out combining synthesis steps as her single biggest anti-pattern; this skill is the guardrail that prevents it.

## When to use

- Granola just synced a discovery interview transcript into the vault
- A recorded interview was transcribed via Fireflies, Otter, etc.
- You took live interview notes and want them structured
- You are about to run discovery-process Phase 4 (synthesis) and have raw transcripts

## When NOT to use

- For internal team meetings (use post-meeting skill)
- For usability tests (they need a different schema: task-by-task observations)
- For NPS surveys or quantitative survey data
- To synthesize multiple interviews at once. **Never.** Run this skill once per interview, THEN move to cross-interview synthesis.

## The schema (five sections, in order)

### 1. Experience Map

A timeline of what the participant actually did. First-person, past tense, concrete. Not what they *would* do or what they *usually* do, but what happened the most recent time.

Structure:

```markdown
**Trigger:** What kicked off the experience
**First action:** Literal first thing they did
**Next steps:** Ordered sequence of what followed
**Tools / people touched:** Every app, site, document, human involved
**Outcome:** Did they finish? Abandon? Partially succeed?
**Time spent:** Actual duration if available, estimate if not
```

### 2. Opportunities

Moments where the participant hit friction, confusion, frustration, or made a workaround. One bullet per opportunity. Each bullet must include a direct quote.

```markdown
- **[Label]**: [One-sentence description]. "[Verbatim quote]" (timestamp if available)
```

An "opportunity" in Teresa's vocabulary is not a solution idea. It's a problem moment worth addressing. Do not write solution hypotheses here.

### 3. Quick Facts

Structured fields for later querying and segmentation.

```markdown
| Field | Value |
|---|---|
| Role | |
| Company / context | |
| Team size | |
| Tool stack | |
| Tenure in role | |
| Frequency of the experience | |
| Prior alternatives tried | |
```

Leave fields blank rather than guessing. Confidence ranking matters downstream.

### 4. Salient Quote

One verbatim quote that captures the emotional or strategic heart of the interview. 1-3 sentences. If the interview has no such quote, write "None, transcript is procedural."

This is the quote you would paste into a stakeholder presentation. Choose ruthlessly.

### 5. Miscellaneous

Anything that didn't fit the above but might matter later. Surprises, off-topic remarks that reveal context, observations about the participant's demeanor. Keep it short. If it's empty, write "None."

## Output file

```
discovery/{cycle-name}/interviews/YYYY-MM-DD-{participant-first-name-lowercase}.md
```

Example: `discovery/day90-churn/interviews/2026-04-22-maria.md`

If no discovery cycle exists yet, ask for a cycle slug or default to `discovery/interviews/`.

Frontmatter:

```yaml
---
date: 2026-04-22
participant: Maria Alonso
role: Head of Growth
company_context: B2B SaaS, Series A
project: discovery-copilot
tags: [interview, discovery, pm-pilot]
source: granola://meeting-id-or-transcript-url
synthesis_status: single-interview-complete
---
```

The `synthesis_status: single-interview-complete` line is the gate flag. The cross-interview synthesis step checks for this string before accepting the file.

## Hallucination guard (required)

Teresa documented a 30% quote hallucination rate when AI synthesizes interviews. Before delivering the Interview Snapshot, run this check:

1. For every direct quote in the output, grep the source transcript for at least 60% of the words (exact match, case-insensitive).
2. If the match fails, flag the quote with `[UNVERIFIED - edit before citing]` and keep going.
3. Never silently fix a quote you cannot match. Mark it, move on.

## Integration with other skills

- **Upstream**: `/pm-discovery:product-discovery interview` designs the questions before the interview happens. Any transcript source works: Granola, Fireflies, Otter, or hand-typed notes.
- **Downstream**: `/pm-core:synthesize-interviews` reads all snapshots tagged `synthesis_status: single-interview-complete` from the folder, not the raw transcripts. Run this skill once per interview first.
- **Never**: do not hand raw transcripts straight to a cross-interview synthesis step. That is the anti-pattern this skill exists to prevent.

## Source

Teresa Torres, Product Talk. See:
- https://www.producttalk.org/customer-interview-analysis-ai/
- https://www.news.aakashg.com/p/teresa-torres-podcast
