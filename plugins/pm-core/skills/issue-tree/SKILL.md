---
name: issue-tree
description: |
  Structure a messy problem into a MECE issue tree before diagnosing, planning, or deciding. Three tree types: Why (find causes), What (break down a deliverable into work), How (rank possible actions). Prevents mixing cause-finding, planning, and solutioning into one muddled discussion. Triggers on: "issue tree", "why tree", "root cause tree", "break this down", "structure this problem", "MECE", "what's actually going on with X".
origin: pm-pilot
version: 1.0.0
---

# Issue Tree: Structure Before You Solve

A classic McKinsey-style tool for splitting one messy problem into three separate jobs: finding the cause, planning the work, and picking an action. Most problem discussions fail before anyone opens a doc, because the team never agreed which of those three jobs it was doing. Someone proposes a fix while another person is still arguing about the cause. Nobody notices, because both look like "talking about the problem."

## When to activate

- User says "issue tree", "why tree", "how tree", "structure this problem", "break this down", "root cause"
- A metric is off and nobody has agreed on the cause yet ("activation is down, what do we do")
- A deliverable needs a workplan and the pieces are still tangled ("we need a PRD but I don't know where to start")
- Multiple options are on the table and none has been ranked ("should we do A or B or C")
- Before invoking `prioritize` or `prd` on a problem that has not been framed yet

## Step 1: Name the actual question first

Do not build a tree until this is answered. Ask the user directly if it is not obvious from context:

**"Do you need to find a cause, build a plan, or pick an action?"**

That question maps to exactly one tree. Building the wrong tree, or all three before deciding which is needed, is the failure this skill exists to prevent.

| If the user needs to... | Build a | Root question shape | Leaves are | Output |
|---|---|---|---|---|
| Explain why a metric moved | **Why-tree** | "Why is X happening?" | Candidate cause families | Testable hypotheses, ranked by likelihood |
| Turn a deliverable into a workplan | **What-tree** | "What does producing X require?" | Analyses, decisions, commitments, artifacts | Sequenced workplan |
| Choose among possible actions | **How-tree** | "How might we achieve X?" | Concrete interventions | Ranked options |

A How-tree only makes sense once a cause is confirmed or a goal is fixed. Building one before the Why-tree is settled just relabels guesses as options.

## Step 2: Draft the branches

Every tree is a root question with 3 to 5 top-level branches, each of which can split further if a branch is itself too broad to act on. Two to three levels deep is almost always enough; a fourth level is a sign the problem was never scoped down before drafting.

**Why-tree.** Split candidate causes into families that do not overlap: something like acquisition mix, product experience, and incentive structure, never three flavors of the same explanation. Each leaf should be phrased as something you could go check, not a conclusion. "Onboarding drop-off in step 2" is checkable. "The product isn't sticky" is not.

**What-tree.** Split the deliverable into the kinds of work it needs, not chronological steps: evidence to gather, decisions to make, commitments to lock down from stakeholders, and the synthesis that depends on all three. Tag each leaf with what kind of work it is (`[ANALYSIS]`, `[DECISION]`, `[COMMITMENT]`, `[SYNTHESIS]`) so the sequencing is visible: synthesis leaves always depend on the others and go last.

**How-tree.** Split possible actions into families tied to a confirmed cause or constraint, not into every idea in the room. If a branch cannot be traced back to something the Why-tree or the goal established, cut it or flag it as speculative.

## Step 3: Run the MECE check

MECE means Mutually Exclusive, Collectively Exhaustive: no branch at a level should overlap another, and together they should cover the space, or explicitly flag what is left out.

Check every level, not just the top:

1. **Overlap check.** For each pair of sibling branches, ask: could one real-world fact belong to both? If yes, redraw the split until it can't.
2. **Coverage check.** Ask: is there an obvious cause, work item, or option that fits none of these branches? If yes, either add a branch or state out loud that it is deliberately out of scope.
3. **Repeat at each level**, not only at the root. A tree that's MECE at level one and sloppy at level two still produces weak conclusions.

A tree passing this check is structurally sound. It is not proof the tree is *true* — that still needs real data, not a clean diagram. Say so when handing the tree back: structure and correctness are different claims.

## Output format

Render as a plain-text tree, root question first, output stated at the bottom:

```
WHY: Why is new-user activation underperforming?
├── 1. Onboarding friction (drop-off inside the flow itself)
├── 2. Acquisition-audience mismatch (right flow, wrong users)
└── 3. Weak activation incentive (right users, no reason to finish)
Output: three testable hypotheses, rank by what's cheapest to check first
```

For a What-tree, tag leaf types so the sequencing reads at a glance:

```
WHAT: What does shipping the tiered-ESP PRD require?
├── 1. Evidence
│   └── 1.1 [ANALYSIS] Confirm the paying-user share and segment counts against source data
├── 2. Choices
│   └── 2.1 [DECISION] Four-group tier structure vs three
├── 3. Agreements
│   └── 3.1 [COMMITMENT] Who signs off on the corridor numbers before send
└── 4. Synthesis
    └── 4.1 [SYNTHESIS] Draft PRD, depends on 1-3
Output: sequenced workplan, synthesis last
```

## After the tree

- **Why-tree** output feeds real investigation: go check the top hypothesis before building anything on top of a guess.
- **What-tree** output is a workplan; hand analysis and decision leaves to whoever owns them, and use `prd` once evidence and decisions are in.
- **How-tree** output is a ranked option list; run it through `prioritize` (RICE, ICE, or Value/Effort) for a defensible order, or `critique` to pressure-test the top option before committing.

## Rules

- Never let the user (or yourself) answer a How question while the Why question is still open. If someone proposes a fix mid-diagnosis, name it: "that's a How answer, we're still on Why" and park it.
- A tree with four top-level branches you can't tell apart is not done. Merge or re-cut until each branch earns a different question.
- Leaves are hypotheses or work items, not conclusions. "Growth has plateaued" is not a leaf; it is the root question restated.
- If the user already knows the cause and just wants a plan, skip straight to a What-tree. Don't force a Why-tree nobody needs.
- State plainly when a branch is a guess versus something checked against real data. A tree is a scaffold for thinking, not evidence.
