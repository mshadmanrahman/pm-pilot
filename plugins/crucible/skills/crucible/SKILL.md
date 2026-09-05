---
name: crucible
description: Stress-test an idea under pressure by convening a multi-persona council that debates, rebuts, and returns a verdict. Use for heavy-lift decisions like moonlight strategy, product direction, career moves, or any question where the cost of being wrong is high. Triggers on "crucible", "/crucible", "run this through the crucible", "convene the crucible", "put X in the crucible", and Solo invocations like "give me the First Principles read on X". Not for tactical calls.
---

# Crucible

A council of specialized personas debates one idea under structured conflict. The chair synthesizes into a verdict. Transcripts are saved to disk for second-brain reuse.

Use this when the cost of being wrong is high enough to justify convening 5-10 subagents. For one-lens exploration without a debate, use Solo mode. For tactical questions under five minutes of normal thinking, don't use Crucible at all.

## When to trigger

Trigger on explicit user invocation only. Examples:
- `/crucible <idea>` (Decision mode default)
- `/crucible --council <idea>` or `/crucible --quick <idea>` (Council mode)
- `/crucible --pm <idea>` (PM Daily mode)
- `/crucible --solo <persona> <idea>` or natural language ("give me the First Principles read on X")
- `/crucible --existential <idea>`
- "Run this through the crucible: ..."
- "Convene the crucible on ..."

Do not auto-trigger. This is an expensive skill and the user decides when it runs.

## Five modes

The chair selects mode at intake based on the user's phrasing OR an explicit flag. Most daily use belongs in Council or Solo. Decision and Existential are for real decisions with real stakes.

### Mode 1: Solo (single-persona lens, ~10-15 seconds)

**Triggers:** `/crucible --solo <persona>`, or natural language ("give me the First Principles read on X", "what does the Expansionist think about Y", "Track Record this for me").

**Persona count:** 1. No duels. No chair verdict. The chair's only job is persona-matching and returning the rubric output unchanged.

**Use for:** Exploration, not decisions. When you want one specific lens, not a debate.

**Honesty check:** If you find yourself reaching for Solo to avoid hearing the Contrarian, that's a signal to run Council mode instead.

### Mode 2: Council (daily reflex, ~30-45 seconds)

**Triggers:** "council", "quick crucible", "gut check", "throw rocks at this", "poke holes", "sanity check", `/crucible --council`, `/crucible --quick`.

**Bench:** 5 personas, parallel openings only. No duels. No verdict beyond a one-liner.
- Contrarian (Sonnet, NOT Opus at this tier to keep cost down)
- First Principles (Sonnet at this tier)
- Expansionist (Sonnet)
- Outsider (Haiku)
- Operator (Haiku)

**Output:** Five short challenges (80-120 words each) plus a one-line "proceed / shelve / reframe" call from the chair. No transcript file unless the user asks.

**Use for:** Daily PM ideation, "I just thought of X, is it dumb?", quick sanity checks between meetings.

### Mode 3: PM Daily (bounded ideation, ~60-90 seconds)

**Triggers:** "pm brainstorm", "pm daily crucible", `/crucible --pm`.

**Bench:** 4 personas, parallel openings, no duels, short verdict.
- Contrarian (Sonnet)
- Operator (Haiku)
- First Principles (Sonnet at this tier)
- Expansionist (Sonnet)

**Output:** Four one-paragraph challenges plus a chair verdict (proceed / shelve / reframe + one concrete next action if proceed). Transcript optional.

**Use for:** PM-specific work ideation, feature direction, user research design, anything that deserves more than "throw rocks" but less than a full decision council.

### Mode 4: Decision (current default, 9-11 personas)

**Triggers:** `/crucible`, "convene the crucible", "run this through the crucible", or the skill's default when the user's phrasing implies a real decision.

**Bench:** Core 6 plus bench-specific specialty per `references/benches.md`, typically 9-11 personas. Full duels. Full verdict. Transcript written.

**Use for:** Real decisions with multi-week time at stake, or money, or reputation.

### Mode 5: Existential (Heavy Custom, all 17 personas)

**Triggers:** User explicitly flags "existential", "life decision", "full crucible", or chair detects the question framing implies existential scope.

**Bench:** All 17 personas. Full duels. Extended verdict.

**Use guardrail:** If invoked more than once per quarter, chair warns: "You've convened the Existential tier N times in M days. These questions usually move slower than that. Proceed anyway?"

## Motivated-convening guardrail (added 2026-04-19)

Before firing any Decision or Existential mode council, the chair asks three questions at intake:

1. **Has a structurally similar question been convened in the last 30 days?** (Chair should glob `~/Documents/VibeCoding/_scratch/crucible/` for recent transcripts and compare topic proximity. If a near-duplicate exists, show its verdict and ask: "Is this a re-run of that, or genuinely new?")
2. **What decision does a verdict produce that you will act on in the next 14 days?** If the user cannot name a concrete action, the chair should say: "This looks like a discussion, not a decision. Use Council mode instead."
3. **What new information has arrived since you last thought seriously about this?** If the honest answer is "none, just renewed energy," the chair should say: "Run 2 on 2026-04-19 named this pattern 'appetite disguised as governance.' Proceed anyway, or reframe?"

The chair never REFUSES to run. It names what it is seeing and lets the user decide. This is the skill's main defence against becoming a procrastination ritual.

## Core design

**17 personas, 1 chair.** The chair selects 1-17 personas per run based on mode and problem type (see `references/benches.md`). The Core 6 are always convened in Decision and Existential modes. The rest are activated by bench.

**Four phases.** Intake, opening takes, pair duels, verdict.

**Model routing per persona.** Haiku for rubric-driven checks, Sonnet for judgment, Opus for Contrarian, First Principles, Consequences, and Chair.

**Transcripts persist.** Full debate writes to `~/Documents/VibeCoding/_scratch/crucible/YYYY-MM-DD-{slug}.md`. Main thread sees only the verdict and a link. Thinking is preserved, context stays clean.

**Rubrics prevent theater.** Each persona has concrete deliverables (cite an analog, estimate a number, name a mechanism), not just "give your take". See `references/personas.md`.

## Phase 1: Intake

The chair (main thread, Opus) does three things:

1. **Classify the input.** Is this a *problem statement* ("should I do X?") or a *proposed solution* ("here's my plan, tear it apart")? Frame the persona prompts differently for each.

2. **Select the bench.** In Decision and Existential modes, always convene the Core 6: Contrarian, Advocate, Pre-mortem, Operator, First Principles, Expansionist. Add specialty personas based on problem type per `references/benches.md`.

3. **Restate and confirm.** Before spinning up subagents, restate the question in one sentence and ask the user to confirm or correct the framing. Do not skip this. Mis-framed questions produce sharp answers to the wrong thing.

## Phase 2: Opening takes (parallel subagents)

Spawn one subagent per selected persona **in parallel** (single message, multiple Agent tool calls). Each subagent:

- Uses `general-purpose` subagent_type
- Uses the model tier specified in `references/personas.md`
- Receives a self-contained prompt containing: the persona's full rubric, the user's idea, the framing mode (problem vs solution), and the output length constraint
- Writes a direct response back; no file writes at this phase

Personas cannot see each other's openings. This is deliberate; it prevents contamination and produces honest independent takes.

Collect all opening takes before moving to Phase 3. Store them internally as labeled blocks (`{persona_name}_opening`).

## Phase 3: Pair duels (serial subagents, anonymized rebuttals)

**Central duel (MANDATORY in Decision and Existential modes):**
- **First Principles vs Expansionist** is the spine of Crucible. Strip-to-bedrock vs scale-to-100x is the highest-value tension this council generates. It always fires when both personas are in the bench (always true in Decision and Existential modes). The chair must address its resolution in the verdict.

**Other duels (activated only if both personas are in the current bench):**
- **Advocate vs Contrarian:** is the premise valid?
- **Operator vs Historian:** can we ship it, has anyone shipped it?
- **Economist vs Consequences:** who pays, and then what?
- **Success Vision vs Worst Case Cost:** best case vs worst case, in concrete numbers
- **Track Record vs Reframer:** your past patterns vs the meta-question: are you pattern-matching correctly or asking the wrong thing?

**Anonymized rebuttals (added 2026-05-23):** When persona A rebuts persona B's opening, the prompt strips B's name and persona label. A sees the opening's content only, not who wrote it. The rebuttal prompt instructs: "Attack the argument, not the persona. You don't know who wrote this." This prevents deference to dramatic framings (e.g., Pre-mortem's 12-month-failure scene tends to win on tone, not substance) and forces argumentative honesty.

For each active duel, spawn **two subagents serially**:
1. Persona A reads Persona B's opening (anonymized), writes a rebuttal (100-150 words)
2. Persona B reads Persona A's opening (anonymized), writes a rebuttal (100-150 words)

Unpaired personas in the bench (Goals Check, Outsider, Regulator, Pre-mortem when its old partner is gone) skip the duel phase and weigh in at verdict.

## Phase 4: Chair verdict (main thread, Opus)

The chair reads all openings and rebuttals, writes the transcript file, and issues a verdict.

**Transcript file.** Write to `~/Documents/VibeCoding/_scratch/crucible/YYYY-MM-DD-{slug}.md` with sections:
- Question (as restated and confirmed at intake)
- Bench convened (list of personas, model used)
- Opening takes (one section per persona)
- Duels (one section per active duel, both rebuttals)
- Unpaired voices (Goals Check, Outsider, Regulator if present)
- Verdict (the chair's output, duplicated here)

Use `date -u +"%Y-%m-%d"` for the filename date.

**Inline verdict format** (this is what the user sees in the chat):

```
## Crucible Verdict

**Question:** {restated question}
**Bench:** {n} personas convened

**Verdict:** PROCEED | REFRAME | KILL
**Reasoning:** {2-3 sentences tying to the strongest arguments}

**First Principles vs Expansionist:** {1-2 sentences naming where bedrock and 100x landed; mandatory in Decision and Existential modes}

**Strongest unresolved objection:** {one sentence}, from {Persona name}

**If PROCEED:** Next action: {one concrete step}
**If REFRAME:** New framing: {one sentence}
**If KILL:** Failure mechanism: {one sentence}

**Goals check:** {Goals Check finding, one line, if activated}

**Minority report:** {named persona}: "{one sentence quoted dissent}"

**Full transcript:** `_scratch/crucible/YYYY-MM-DD-{slug}.md`
```

The minority report is mandatory. Even on a unanimous PROCEED, surface the strongest cautionary voice. This prevents false consensus.

The First Principles vs Expansionist resolution line is also mandatory in Decision and Existential modes. If the chair cannot name where the two landed, the chair has not done its job.

## Orchestration rules

- **Parallelize Phase 2.** All opening takes fire in a single message with multiple Agent tool calls. Do not serialize.
- **Serialize Phase 3.** Duels run sequentially because the second persona needs to see the first rebuttal. Within a duel, fire the two rebuttals in parallel (each reads the opposing opening, not the opposing rebuttal).
- **Anonymize rebuttal prompts.** Strip persona names and labels from the opening being rebutted. Tell the rebuttal subagent: "Attack the argument, not the persona."
- **Never skip intake confirmation in Decision or Existential modes.** If the user's input is ambiguous, restate and ask. One extra round trip costs nothing; a mis-framed council costs 10 subagents.
- **Solo mode skips intake confirmation.** Just match the persona and spawn the subagent. The user already named what they want.
- **Respect the roster.** Do not invent new personas mid-run. If the problem genuinely needs a persona not in the roster, flag it in the verdict as "council gap" and recommend adding one.
- **Track Record requires file access.** When Track Record is in the bench, the subagent prompt must include the reading list (MEMORY.md, relevant shards, recent handoffs). See `references/personas.md` for specifics.

## Cost expectations

A typical moonlight-strategy run: 10 personas (Core 6 + Personal bench 4) plus chair. Roughly:
- 2-3 Haiku subagents (Operator, Goals Check, Worst Case Cost): cheap
- 5-6 Sonnet subagents: moderate
- 2 Opus subagents (Contrarian, First Principles) plus Chair: the expensive ones, justified by their leverage

User is on subscription; dollar cost is not the constraint. The constraints are time (10 subagents takes 30-60 seconds) and main-thread context (verdict + minority report only, transcript on disk).

Council mode (5 personas, all Sonnet/Haiku) is the cheap daily reflex.
Solo mode (1 persona) is near-free.

## Files in this skill

- `SKILL.md`, this file, the orchestration spec
- `references/personas.md`, all 17 persona rubrics with model tier and output format
- `references/benches.md`, problem-type to bench mapping plus all 5 modes

Load `references/personas.md` and `references/benches.md` at intake. They are the runtime data the chair needs.

## Anti-patterns to avoid

- **Council theater.** Personas that give vibes instead of concrete deliverables. Enforce the rubric.
- **Mediator mush.** Chair that summarizes instead of deciding. Always issue a verdict.
- **False consensus.** Verdict that hides dissent. The minority report is not optional.
- **Bench creep.** Convening all 17 personas "to be thorough". Thorough means the *right* personas for *this* problem, not all of them. Every persona is a fixed cost regardless of how short its answer is (measured at roughly 125K tokens per subagent spin-up, 2026-09-05, three separate tests across trivial and substantial tasks landed within 9% of each other). A bench is not free just because the answer is short. Exception: Existential mode is legitimate when the user explicitly flags an existential decision.
- **Auto-triggering.** Firing the crucible on questions that don't warrant it. Explicit invocation only.
- **Solo as Contrarian-avoidance.** Reaching for Solo mode to hear only the lens that will validate you. If you notice this, escalate to Council.
- **Volitional inference.** Drawing narrative claims about user choice ("walked away from", "gave up on", "doesn't want to own", "rejected as a model") from evidence that doesn't support volition. Especially dangerous when mixing personal moonlight with client/contract work. A project ending under someone else's ownership is not the user choosing to exit. Caught Run 1 on 2026-04-19 when Track Record (then Archivist) cited Wisebox (client work for family friends) as evidence of the user "walking away from the SaaS model." See Track Record guardrails in `references/personas.md`.
- **Skipping the central duel.** In Decision and Existential modes, First Principles vs Expansionist is mandatory. If the chair skips it or fails to address its resolution in the verdict, the run is incomplete.

## Changelog

- **2026-09-05:** Added a measured cost figure to the bench creep anti-pattern (roughly 125K tokens per subagent spin-up, fixed regardless of task size). Added a chair rule in `references/benches.md`: name why each convened persona earns its spot, not just which bench matched the problem type.
- **2026-05-23:** Promoted First Principles (new) and Expansionist (replaces Ambition Stretcher) to Core, making it Core 6. Mandatory First Principles vs Expansionist duel in Decision and Existential modes. Renamed 9 personas for plain-English clarity (Steelman→Advocate, Pre-mortem Pessimist→Pre-mortem, Archivist→Track Record, Values Compass→Goals Check, Downside Floor→Worst Case Cost, Competitor/Mirror→Competitor, Second-Order Thinker→Consequences, Naive Outsider→Outsider, Operator/Builder→Operator). Added Solo mode for single-lens exploration. Renamed Quick mode to Council mode and shifted its bench to the LLM Council 5 (Contrarian, First Principles, Expansionist, Outsider, Operator). Anonymized rebuttals in Phase 3.
- **2026-04-19:** Added motivated-convening guardrail. Added Track Record (then Archivist) ownership-classification guardrails after Run 1 volitional-inference error.
