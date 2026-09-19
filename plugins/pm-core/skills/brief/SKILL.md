---
name: brief
description: |
  The front door to PM Pilot. Turns one decision question into an evidence-backed decision brief where every claim carries its source, counter-evidence is stated, and missing evidence is named rather than papered over. Works on a local folder with no MCP setup. Triggers on: "brief", "/brief", "should we", "decision brief", "help me decide", "make the case for", "what does the evidence say about".
origin: pm-pilot
version: 1.0.0
---

# Brief

One command, one decision, one reviewable artifact.

```
/pm-core:brief "Should we prioritize bulk import for mid-market?"
```

This is the first thing a new user should run. It needs no MCP servers, no configuration, and no knowledge of the other skills. It reads a folder of evidence, produces a decision brief, and forces a decision state at the end.

## When to Activate

- User runs `/pm-core:brief` with or without a question
- User asks "should we X", "help me decide on X", "make the case for X"
- User asks what the evidence says about a decision they are facing
- A new user has just installed PM Pilot and does not know where to start

## The contract

A brief is not a summary. It is an argument with its sources attached, and it is only useful if a reader can check it. So:

- Every consequential claim names where it came from.
- Every direct quote is verified against its source before delivery.
- Evidence that cuts against the recommendation is stated, not omitted.
- Evidence that does not exist is named as missing, not inferred.
- The brief ends in a decision state, not in a draft.

If you cannot meet all five, say which one failed and why. Never deliver a brief that looks complete when it is not.

## Execution

### Step 1: Name the decision

Take the decision from the user's argument. If they ran the command bare, ask once:

> What decision are you trying to make? One sentence, phrased as a question.

Reject a topic disguised as a decision. "Bulk import" is a topic. "Should we prioritize bulk import for mid-market this quarter?" is a decision. If the user gives a topic, offer the sharpest decision question you can infer from it and ask them to confirm or correct it in one line.

Do not proceed past a vague decision. Everything downstream inherits the framing.

### Step 2: Confirm sources, once

Look for evidence in this order and show the user what you found:

1. The current folder and any `evidence/`, `research/`, `interviews/`, `notes/`, `transcripts/` subfolder
2. `context/product.md`, `context/company.md`, `context/personas.md`, `context/competitors.md` if they have content
3. Connected MCP tools, if any are available (Jira, Slack, Confluence, Granola, GitHub)

Report it as a short list and ask one question:

> Found 14 files in `research/` and 3 context files. Jira and Granola are connected. Use all of these, or point me somewhere else?

Accept a yes and move. Accept a path and use it. This is the only confirmation gate in the whole flow. Do not ask again later.

If nothing is found, say so plainly and ask for a folder or a paste. Never invent a source, and never produce a brief from the model's own background knowledge while implying it came from the user's evidence.

### Step 3: Gather and verify

Route to the skills that already exist rather than duplicating them:

| Evidence type | Skill to use |
|---|---|
| Customer interviews and transcripts | `/pm-discovery:interview-snapshot`, then `/pm-core:synthesize-interviews` |
| Cross-tool history on a topic | `/pm-core:deep-context` |
| Competitive and market claims | `/pm-content:market-research` |
| A messy causal question underneath the decision | `/pm-core:issue-tree` |

Apply the hallucination guard from `synthesize-interviews` to every direct quote regardless of which path produced it. Search the source for at least 60% of the quote's words, exact match, case insensitive. Flag any miss inline with `[UNVERIFIED - edit before citing]` and keep going. Never silently repair a quote.

### Step 4: Write the brief

Use the output format below. Keep it to one screen for the body. Depth belongs in the evidence table, not in the prose.

### Step 5: Force a decision state

A brief that ends as a draft has not done its job. Close by asking the user to pick one:

- **Decide.** The evidence is sufficient. Record the call and the reasoning.
- **Defer.** Right call, wrong time. Record what has to change for this to come back.
- **Experiment.** The uncertainty is testable. Record the smallest test that would settle it.
- **Research.** The evidence gap is real. Record exactly what is missing and who can get it.

Write their answer into the brief before saving. A brief with no decision state is incomplete.

## Output format

```markdown
# Decision Brief: <the decision question>

**Date:** YYYY-MM-DD
**Sources reviewed:** <n files, n tools>
**Quotes verified:** 12/13 verified against source

## Recommendation

<Two sentences. The call, and the single strongest reason for it.>

## The case for

- <Claim.> [source: interviews/acme-2026-08-14.md, verified]
- <Claim.> [source: Jira INS-3128, verified]

## The case against

- <Claim that cuts against the recommendation.> [source: ...]

State at least one, and mean it. If the evidence genuinely runs one way, write
"No counter-evidence found in the reviewed sources" and treat that as a warning
sign about the sources rather than a strength of the argument.

## What we do not know

- <Missing evidence, and what it would take to get it.>
- <Question no source in this set can answer.>

## Confidence

<One of: high, medium, low.> <One sentence naming what would move it.>

## Decision

**State:** decide | defer | experiment | research
**Call:** <what was decided>
**Revisit when:** <trigger>
```

Save to `briefs/YYYY-MM-DD-<slug>.md` unless the user says otherwise.

## Rules

- One confirmation gate, in step 2. Everything else runs without asking.
- Never present an inference as a sourced claim. An inference is labelled as yours.
- A claim you cannot trace to a source in the confirmed set does not go in the brief. It goes in "What we do not know".
- Do not soften a weak evidence base with hedged prose. Say the base is weak and name what is missing.
- Web search is allowed for market and competitor claims, and those get their URL in the source tag like any other claim.
- If the user's own prior decisions contradict the recommendation, surface that in "The case against".

## Integration with other skills

- **Upstream**: nothing. This is the entry point.
- **Downstream**: `/pm-core:prd` turns a decided brief into a spec. `/pm-core:critique` pressure-tests the brief before it goes to a stakeholder. `/crucible:crucible` for a decision big enough to deserve a council.
- **Sibling**: `/pm-core:prioritize` when the question is a ranking across many items rather than one call.
