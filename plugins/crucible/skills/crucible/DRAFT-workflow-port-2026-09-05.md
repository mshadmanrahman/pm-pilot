---
status: draft, not adopted
created: 2026-09-05
---

# Draft: porting Decision mode onto the Workflow tool

Not shipped. Kept here so the design work and the critique that followed it
are not lost. Read this before picking the idea back up.

## What this was trying to do

Move Decision mode's fan-out (openings, duel pairs) off the plain Agent tool
and onto the newer Workflow tool: a sandboxed script that runs parallel()/
pipeline()/agent() calls in the background and returns one result, instead of
the chair (main thread) issuing one round of tool calls per phase and holding
the growing transcript in its own context the whole time.

## Two rounds of external critique, both SHIP WITH CHANGES

A Fable subagent and Codex CLI (read-only, via Bash) reviewed the v1 draft
independently. Both converged on the same top two problems without seeing
each other's replies:

1. Rebuttal calls dropped each persona's rubric and model, keeping only the
   name.
2. The script's return value still handed the full council transcript back
   to the main thread, which limits any real saving to turn collapse only,
   not a smaller final payload, unless the script performs its own synthesis
   before returning.

Both also caught an unguarded `byName[b]` lookup that goes `undefined` if an
opening fails, and both flagged that Existential mode was named in scope but
never scripted. Fable additionally caught that the Codex/Gemini Bash calls
need `run_in_background: true` or they block the whole turn, and that
`SKILL.md`'s own Phase 2 to 4 prose becomes dead weight once a script owns
sequencing, and should shrink.

v2 fixed all of that: rubric/model preserved per rebuttal, a guard that skips
any duel pair missing an opening, a Digest phase that condenses the debate
before it reaches the chair, Existential explicitly descoped, and a written
compaction invariant (raw persona text never crosses into the main thread,
only the digest does).

## The finding that changes the calculus

Three separate subagent calls were timed this session, against wildly
different tasks: a Fable subagent critiquing a 1,500-word draft (122,036
tokens), a workflow `agent()` call writing one line to a file (125,898
tokens), and a plain Agent-tool call doing the identical one-line write with
no Workflow involved (133,477 tokens). All three land within about 9% of each
other. That reads as a fixed per-subagent cost floor, not something task size
or the Workflow tool changes.

This was tested specifically to confirm a workflow `agent()` call can Write
directly to disk (it can; the test file was verified on disk with matching
content), which would let a scribe agent write the transcript without the
main thread ever holding the raw text. That part of the design works.

What it does not do is make the digest-plus-scribe addition a net token
saving. The original motivation was collapsing four main-thread turns into
one, worth roughly 30 to 50K tokens per turn avoided (Fable's estimate, tied
to this user's own measured cache-read-dominated cost model), so three turns
collapsed is roughly 90 to 150K tokens saved. But v2 added two new subagent
calls that did not exist in the naive four-phase version: the Digest agent
and the scribe agent. At roughly 125K each, that is 250K in new cost to save
90 to 150K. **Net, the "improved" v2 design is likely more expensive in raw
tokens than the plain v1 version that just returns everything, and quite
possibly more expensive than not porting to Workflow at all.**

The digest and scribe stages may still be worth keeping for reasons that are
not about token count: a cleaner main-thread context for the chair's own
reasoning, or a design that scales better once transcripts get long enough
that raw text would blow past a context window regardless of price. But they
should not be sold as a cost optimization. They are not one, given a fixed
per-subagent floor this large.

## What actually is cheap to fix, and shipped already

Given the floor, the number of subagents spawned matters far more than how
each one is orchestrated. `SKILL.md`'s "bench creep" anti-pattern and
`references/benches.md`'s chair selection logic were both updated 2026-09-05
with the measured cost figure and a new rule: the chair must name why each
convened persona earns its spot, not just which bench matched the problem
type. That shipped. This Workflow port did not, and should not be picked back
up as a cost play; if it's picked up again, the reason should be something
other than token savings.

## Open items if this gets revisited

- Confirm whether the roughly 125K floor comes from this session's large MCP
  tool surface, its large always-loaded rules set, or both. Needs a test from
  a leaner session with fewer connected tools; could not be run from here.
- If revisited, script and critique Existential mode separately rather than
  assuming Decision mode's shape generalizes.
- The corrected v2 script (rubric/model preserved, missing-opening guard,
  Digest phase, compaction invariant) is in the session transcript of
  2026-09-05; not reproduced here in full since it should not ship until the
  cost tradeoff above is resolved.
