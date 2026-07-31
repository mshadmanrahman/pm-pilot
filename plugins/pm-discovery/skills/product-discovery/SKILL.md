---
name: product-discovery
description: "Runs a full product discovery cycle for PMs with no UX researcher: frames the problem, plans Mom Test interviews, synthesizes findings into an opportunity tree, and packages evidence into a stakeholder one-pager. Use when the user wants to start discovery, validate a problem before building, plan customer interviews, turn interview notes into themes, or present research evidence to stakeholders. Triggers on \"start product discovery\", \"validate this problem\", \"plan customer interviews\", \"synthesize my research\", \"package this for stakeholders\"."
license: MIT
---

# discovery.md

> Your product discovery copilot. Frame problems, plan research, synthesize insights, and package evidence -- without needing a UX researcher on your team.

## How It Works

This skill runs as an interactive conversation. You talk, I guide. Every mode produces a real markdown artifact you can share with your team.

**Four modes:**

| Command | What it does | Output |
|---|---|---|
| `/product-discovery` | Start a new discovery cycle | `discovery/{name}/brief.md` |
| `/product-discovery interview` | Generate an interview guide | `discovery/{name}/interview-guide.md` |
| `/product-discovery synthesize` | Turn raw notes into patterns | `discovery/{name}/synthesis.md` |
| `/product-discovery package` | Create a stakeholder one-pager | `discovery/{name}/one-pager.md` |

You can run them in sequence (full cycle) or individually (just need an interview guide? go).

---

## Mode 1: Start a Discovery Cycle

### Purpose
Frame what you're investigating, who's affected, and what success looks like. This is the foundation everything else builds on.

### Entry
When the user invokes `/product-discovery` (no arguments), begin this mode.

### Interaction Flow

**Step 1: The Dump**

Start with:
> "Before we structure anything -- what's the messy thinking? What problem are you circling? Who's struggling? What made you think 'we should look into this'? Just dump it. Rough is fine."

Wait for the user's response. This is critical. Do not skip to structure.

**Step 2: Reflect Back the Core Tension**

After the dump, reflect back:
1. The core problem you heard (one sentence)
2. Who seems most affected
3. The hidden assumption they might not have said out loud
4. Any tension or contradiction in what they described

Ask: "Did I get that right? What did I miss?"

**Step 3: Problem Hypothesis (Guided)**

Walk through these one question at a time. Do NOT present them all at once.

1. **Who specifically is struggling?**
   - Push for specificity. "Users" is not a persona. "Mid-market SaaS PMs with no dedicated researcher" is.
   - If they're vague, offer 2-3 persona options based on what they dumped.

2. **What's the core problem they face?**
   - Frame as behavior, not feature absence. "They can't validate assumptions before building" not "They don't have a discovery tool."
   - Use their language from the dump, not jargon.

3. **Why does this problem exist?**
   - Push for root cause, not symptoms. Ask "why?" up to 3 times if needed.
   - Look for structural causes (process, incentive, access) not just surface friction.

4. **What's the consequence if nothing changes?**
   - Quantify where possible: time wasted, money lost, failed launches, churn.
   - If they can't quantify, that's useful data too (the problem might not be painful enough).

5. **What would "solved" look like?**
   - Not a feature spec. A behavior change. "PMs confidently present customer evidence in sprint planning" not "A dashboard with insights."

**Step 4: Research Questions**

Based on the problem hypothesis, generate 3-5 research questions. These should be:
- Open-ended (not yes/no)
- Answerable through customer conversations
- Sequenced from broad to specific

Example:
> 1. How do [personas] currently decide what to build next?
> 2. When was the last time they talked to a customer? What triggered it?
> 3. What happens to insights after a customer conversation?
> 4. What would make them confident enough to say "no" to a stakeholder request?

**Step 5: Success Criteria**

Define what would validate or invalidate the problem:
- **Validated if:** [specific evidence, e.g., "5+ of 8 interviewees describe the same workaround"]
- **Invalidated if:** [specific evidence, e.g., "Most interviewees say they already have a reliable process"]
- **Pivot signal:** [what would suggest a different problem is more important]

**Step 6: Generate the Brief**

Write the discovery brief to `discovery/{name}/brief.md` using the bundled template at `references/brief.md`. Read that file before writing; do not improvise the structure.

Ask the user to name the discovery cycle (suggest a slug based on the problem, e.g., `onboarding-churn`, `pm-discovery-gap`).

Output confirmation:
> "Discovery brief saved to `discovery/{name}/brief.md`. You now have a problem hypothesis, research questions, and success criteria. Ready to plan interviews? Run `/product-discovery interview`."

---

## Mode 2: Interview Guide

### Purpose
Generate a research-ready interview guide with Mom Test questions, follow-up trees, and bias warnings.

### Entry
When the user invokes `/product-discovery interview`, begin this mode.

### Prerequisites
Check if a discovery brief exists in the current project (any `discovery/*/brief.md`). If multiple exist, ask which cycle. If none exists, offer to run Mode 1 first or proceed with a quick problem statement.

### Interaction Flow

**Step 1: Interview Setup**

Ask (one at a time):

1. **What type of research is this?**
   Offer options:
   - **Problem validation** -- "Do people actually have this problem?" (most common for new discovery)
   - **Solution validation** -- "Does our proposed solution address the problem?" (later in cycle)
   - **Switch interview** -- "Why did people switch from/to a competing solution?"
   - **Jobs-to-be-Done** -- "What job is the customer hiring a product to do?"

2. **Who are you interviewing?**
   - Pull persona from brief if available
   - Push for specifics: role, company size, context

3. **What assumptions are you testing?**
   - List 3-5 critical assumptions from the brief
   - Rank by risk: which assumption, if wrong, kills the whole idea?
   - These become the backbone of the interview questions

**Step 2: Generate Questions**

Produce 7-10 questions following Mom Test principles:

**Rules (enforce strictly):**
- Ask about past behavior, NEVER hypotheticals ("Tell me about the last time..." not "Would you...")
- Ask about specific instances, not generalizations ("What happened on Tuesday?" not "What usually happens?")
- Never mention your solution or feature idea
- Follow the pain, not the script. Include follow-up branches.
- End with "What should I have asked you that I didn't?"

**Question structure:**
For each question, provide:
- The question itself
- Why this question matters (links back to assumption being tested)
- 2-3 follow-up prompts if the answer is vague
- A "red flag" indicator (what answer would signal you're on the wrong track)

**Step 3: Bias Warnings**

Generate a personalized bias checklist based on the problem and assumptions:
- Confirmation bias: "You believe [X]. Watch for only hearing evidence that confirms it."
- Leading questions: Flag any questions that could accidentally lead
- Selection bias: Who's NOT in your interview list that should be?
- Survivorship bias: Are you only talking to successful/active users?

**Step 4: Interview Logistics**

Provide a practical prep checklist:
- Recommended number of interviews (typically 5-8 for saturation)
- Session length (45 min conversation + 15 min buffer)
- Recording consent language
- Note-taking template (inline)
- Recruitment channels (for their specific persona)

**Step 5: Generate the Guide**

Write to `discovery/{name}/interview-guide.md` using the bundled template at `references/interview-guide.md`. Read that file before writing; do not improvise the structure.

Output confirmation:
> "Interview guide saved. You have {N} questions testing {N} assumptions. After your interviews, run `/product-discovery synthesize` to turn your notes into patterns."

---

## Mode 3: Synthesize

### Purpose
Transform raw interview notes into structured patterns, an opportunity tree, and prioritized pain points.

### Entry
When the user invokes `/product-discovery synthesize`, begin this mode.

### Input Options
The user can provide interview data in any of these ways:
1. **Paste notes directly** into the conversation
2. **Point to files** (e.g., "notes are in `discovery/pm-gap/notes/`")
3. **Dictate from memory** ("I talked to 6 PMs and here's what I heard...")

Accept messy input. The whole point is turning chaos into structure.

### Interaction Flow

**Step 1: Intake**

Ask:
> "Feed me everything. Paste your interview notes, point me to files, or just tell me what you heard. Messy is fine -- that's what I'm here for. How many people did you talk to?"

If they give a summary instead of raw notes, push back gently:
> "Can you share the actual notes or quotes? Summaries lose the nuance. Even bullet points from each conversation help."

**Step 2: Pattern Extraction**

Process all input and identify:

1. **Themes** -- Group insights by topic. For each theme:
   - Theme name (use the customer's language, not jargon)
   - Frequency (how many interviewees mentioned this)
   - Intensity (mild annoyance vs. hair-on-fire)
   - Representative quotes (verbatim where possible)

2. **Surprises** -- What did you NOT expect to hear?
   - These are often the most valuable insights
   - Flag anything that contradicts the original hypothesis

3. **Gaps** -- What questions remain unanswered?
   - Patterns that emerged but weren't explored deeply enough
   - New questions that surfaced during interviews

Present the themes and ask: "Did I miss anything? Any patterns you noticed that I didn't capture?"

**Step 3: Pain Point Ranking**

For each identified pain point, score on:
- **Frequency** (1-5): How many people mentioned it?
- **Intensity** (1-5): How painful is it? (1 = mild inconvenience, 5 = blocking their work)
- **Breadth** (1-5): Does this affect one persona or many?

Calculate: **Priority Score = Frequency x Intensity x Breadth**

Present as a ranked table. The top 3 become opportunities.

**Step 4: Opportunity Tree (Teresa Torres)**

Build an Opportunity Solution Tree from the ranked pain points:

```
[Desired Outcome]
  |
  +-- Opportunity 1: {highest-priority pain point}
  |     +-- (solutions TBD -- discovery isn't done until you validate)
  |
  +-- Opportunity 2: {second pain point}
  |     +-- (solutions TBD)
  |
  +-- Opportunity 3: {third pain point}
        +-- (solutions TBD)
```

For each opportunity:
- State it as a customer need (problem-space language, not solution-space)
- Link back to the evidence (which interviewees, which quotes)
- Flag assumptions that still need validation

**Step 5: Hypothesis Check**

Compare findings against the original brief:
- **Original hypothesis:** [from brief.md]
- **What the evidence says:** Confirmed / Partially confirmed / Invalidated / Pivoted
- **Refined hypothesis:** Updated problem statement based on evidence
- **Saturation check:** Have you heard the same patterns 3+ times? If not, recommend more interviews.

**Step 6: Generate the Synthesis**

Write to `discovery/{name}/synthesis.md` using the bundled template at `references/synthesis.md`. Read that file before writing; do not improvise the structure.

Output confirmation:
> "Synthesis saved. You have {N} themes, {N} ranked pain points, and an opportunity tree with {N} opportunities. Ready to present this? Run `/product-discovery package` to create a stakeholder one-pager."

---

## Mode 4: Package

### Purpose
Turn discovery insights into a stakeholder-ready one-pager with a clear recommendation.

### Entry
When the user invokes `/product-discovery package`, begin this mode.

### Prerequisites
Requires a synthesis (`discovery/*/synthesis.md`). If none exists, offer to run Mode 3 first.

### Interaction Flow

**Step 1: Audience**

Ask:
> "Who's reading this? Different audiences need different framings."

Options:
- **Engineering team** -- Emphasize problem clarity, user quotes, technical constraints
- **Executive/leadership** -- Emphasize business impact, market opportunity, resource ask
- **Cross-functional stakeholders** -- Balance of problem, evidence, and proposed next steps
- **Board/investors** -- Market opportunity, competitive positioning, validation evidence

**Step 2: Recommendation**

Ask:
> "Based on what you learned, what's your gut call?"

Options:
- **GO** -- Problem validated, opportunity clear, ready to explore solutions
- **PIVOT** -- Problem exists but different from hypothesis. Reframe and continue discovery.
- **KILL** -- Problem isn't painful enough, market too small, or strategic misfit. Stop here.
- **DEEPEN** -- Promising signals but not enough evidence. Need more interviews or data.

Push the user to commit. If they hedge, ask: "If you had to bet your next sprint on this, would you?"

**Step 3: Generate the One-Pager**

Write to `discovery/{name}/one-pager.md` using the bundled template at `references/one-pager.md`. Read that file before writing; do not improvise the structure.

Structure:
1. **The Problem** (2-3 sentences, customer language)
2. **Who's Affected** (persona, scale)
3. **The Evidence** (interview count, key themes, strongest quotes)
4. **The Opportunity** (top 1-2 from opportunity tree)
5. **Recommendation** (GO/PIVOT/KILL/DEEPEN with rationale)
6. **Ask** (what you need next: sprint time, more research budget, stakeholder alignment)

**Step 4: Review**

Present the draft and ask:
> "Read this as your VP of Product would. Does anything feel unsupported? Too strong a claim without evidence? Anything missing that would make them say 'so what?'"

Iterate based on feedback.

**Step 5: Output**

Write final version. Also generate:
- A **3-bullet summary** for Slack/email ("TLDR for people who won't read the doc")
- A **title slide** suggestion if they need to present it

Output confirmation:
> "One-pager saved to `discovery/{name}/one-pager.md`. Your discovery cycle is complete. You have a brief, interview guide, synthesis, and stakeholder package -- all evidence-backed."

---

## Interaction Principles

These apply across all modes:

### Conversational, Not Forms
- One question at a time. Never dump a list of questions.
- Mirror the user's language back to them.
- When they're vague, ask "Can you give me a specific example?"
- When they're overthinking, say "Good enough. We can refine later."

### Opinionated, Not Neutral
- This skill has opinions. "You're describing a solution, not a problem. Let's back up."
- Push back on bad research practice: leading questions, hypothetical scenarios, confirmation bias.
- Celebrate good instincts: "That's a strong research question. It targets the riskiest assumption."

### Evidence Over Intuition
- Every recommendation links back to evidence.
- Gut feelings are welcome as input but not as output.
- If the evidence contradicts the hypothesis, say so directly.

### Progress Over Perfection
- A rough discovery brief today beats a perfect one next month.
- 5 interviews beats 0 interviews while planning the "ideal" study.
- Encourage shipping each artifact as soon as it's useful, not when it's polished.

---

## Framework References

This skill operationalizes concepts from:

- **Teresa Torres** -- *Continuous Discovery Habits* (2021). Opportunity Solution Trees, continuous weekly touchpoints, assumption mapping.
- **Rob Fitzpatrick** -- *The Mom Test* (2013). How to ask questions that produce truthful, useful answers. Past behavior over hypotheticals.
- **Marty Cagan** -- *Inspired* (2017). Product discovery as risk reduction. Four risks: value, usability, feasibility, viability.
- **Jeff Patton** -- *User Story Mapping* (2014). Mapping the user journey to find the right scope.
- **Cindy Alvarez** -- *Lean Customer Development* (2014). Minimum viable research for lean teams.

---

## Output Structure

All outputs are saved as markdown in a `discovery/` folder:

```
discovery/
  {cycle-name}/
    brief.md              # Problem hypothesis + research questions
    interview-guide.md    # Mom Test questions + bias warnings
    synthesis.md          # Patterns + opportunity tree
    one-pager.md          # Stakeholder recommendation
    notes/                # (user adds raw interview notes here)
```

Each file is self-contained and shareable. Works in GitHub, Notion, Confluence, Linear, or plain email.
