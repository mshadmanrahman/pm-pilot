# Example: Full Discovery Cycle

> This walkthrough shows all 4 modes of discovery.md in action.
> The scenario is realistic but fictional.

---

## Scenario

You're a PM at a B2B SaaS company (project management tool, 2,000 paying teams). Your VP of Product asked: "Why are teams churning after the first 90 days?" You have analytics showing 35% churn in the first quarter, but you don't know why.

You don't have a UX researcher. It's just you.

---

## Mode 1: Start (`/product-discovery`)

### The Dump

**You:**
> "OK so we're losing about 35% of teams in the first 90 days. It's mostly mid-market teams (20-50 people). The weird thing is their initial engagement is high -- they set up projects, invite team members, create boards. Then around week 6-8, usage drops off a cliff. Support tickets spike around integrations -- they keep asking about Jira import and Slack notifications. I think we might have an integrations problem but I'm not sure. We also just raised prices 15% last quarter so maybe that's a factor? I honestly don't know. Our competitors (Linear, Shortcut) have been shipping fast lately."

### Claude Reflects Back

> Here's what I heard:
>
> **Core problem:** Teams adopt actively but disengage at week 6-8, leading to churn by day 90.
>
> **Who's affected:** Mid-market teams (20-50 people) -- your most valuable segment.
>
> **Hidden assumption:** You think it's an integrations gap (Jira, Slack), but that's a hypothesis, not a fact. The support tickets MENTION integrations, but the actual cause of disengagement could be different.
>
> **Tension:** High initial engagement + sudden drop-off is interesting. It suggests the product delivers SOME value but fails to become embedded in their workflow. Integrations could be the "workflow embedding" failure, but so could onboarding complexity, missing team habits, or a champion leaving.
>
> Did I get that right? What did I miss?

### Guided Questions

**Who specifically?**
> "IT project leads at mid-market companies who champion the tool adoption for their team."

**What's the core problem?**
> Teams adopt the tool initially but fail to make it their system of record within 90 days, causing them to revert to their previous tool.

**Why does this exist?**
> First "why": The tool doesn't integrate into their existing workflow (Jira, Slack, GitHub).
> Second "why": Without integrations, team members maintain two systems, which creates friction.
> Third "why": The champion can't enforce adoption when the tool feels like extra work.

**Consequence?**
> 35% of mid-market teams churn (~$420K ARR at risk this quarter). Champion's credibility is damaged. They bad-mouth us to their network.

**Solved looks like?**
> Teams that reach week 8 have connected at least 2 integrations and stopped using their previous tool for daily standups.

### Output: `discovery/day90-churn/brief.md`

```markdown
## Problem Hypothesis

**Who:** IT project leads at mid-market companies (20-50 people) who champion tool adoption

**Problem:** Teams adopt actively but fail to embed the tool into their workflow by week 6-8, causing 35% to churn by day 90

**Root Cause:** Without integrations into existing workflow (Jira, Slack, GitHub), team members maintain parallel systems, creating friction the champion can't overcome

**Consequence:** ~$420K ARR at risk this quarter. Champion credibility damaged. Negative word-of-mouth.

**Solved Looks Like:** Teams reaching week 8 have 2+ integrations connected and have stopped using their previous tool for standups.

### Research Questions
1. What does the first 90 days actually look like for a team that churns vs. one that stays?
2. At what point do team members start reverting to their previous tool? What triggers it?
3. How do champions try to drive adoption? Where do they give up?
4. What role do integrations play vs. other factors (onboarding, features, team habits)?
5. What did retained teams do differently in weeks 1-8?
```

---

## Mode 2: Interview (`/product-discovery interview`)

### Setup
- **Research type:** Problem validation
- **Persona:** IT project leads who championed adoption (mix of churned and retained)
- **Assumptions tested:** (1) Integration gaps cause reversion, (2) Champions give up at week 6-8, (3) Retained teams found a different workflow

### Output: `discovery/day90-churn/interview-guide.md` (excerpt)

```markdown
### Q1: "Walk me through the first week after your team started using [our tool]. What happened?"

**Why:** Establishes baseline adoption behavior before the drop-off.
**Follow-ups:**
- "Who set it up? Was it just you or did others help?"
- "What was the first project you put in there?"
- "How did you get your team to start using it?"
**Red flag:** If they say "I set it up and told everyone to use it" with no adoption strategy, the problem might be change management, not product.

### Q2: "Tell me about the last time someone on your team went back to [old tool] for something they could have done in [our tool]."

**Why:** Directly tests the "parallel systems" hypothesis. Past behavior, not hypothetical.
**Follow-ups:**
- "What were they trying to do?"
- "Why was [old tool] easier for that?"
- "Did you say anything to them about it?"
**Red flag:** If they say "we never went back" -- either they're retained (good sample) or not being honest.

### Q5: "If you could change one thing about the first 90 days, what would it be?"

**Why:** Open-ended, lets them surface the real pain (which might not be integrations).
**Follow-ups:**
- "Why that specifically?"
- "What would have been different if that existed?"
**Red flag:** If they say "nothing" or "lower the price" -- we might be solving the wrong problem.
```

---

## Mode 3: Synthesize (`/product-discovery synthesize`)

### Raw Input (from 7 interviews)

**You paste notes from 7 interviews.** Three churned teams, two at-risk, two retained.

### Output: `discovery/day90-churn/synthesis.md` (excerpt)

```markdown
## Themes

### Theme 1: "The Slack Gap" (6/7 interviewees)
**Intensity:** Hair-on-fire

Teams live in Slack. When task updates don't flow into Slack, team members stop checking [our tool]. They revert to Slack threads for status updates, which defeats the purpose.

> "If it's not in Slack, it doesn't exist for my team." -- P3, Engineering Lead
> "I was copying and pasting updates from [tool] into Slack three times a day. I gave up at week 5." -- P1, Project Lead (churned)

### Theme 2: "Champion Burnout" (5/7 interviewees)
**Intensity:** High

The person who brings the tool in becomes the unpaid admin. They spend 2-4 hours/week maintaining it for the team. When they burn out, nobody picks up the slack.

> "I became the Jira guy. Sorry, the [your tool] guy. Nobody else knew how to set up a board." -- P5, PM (churned)

### Theme 3: "The Week 3 Wall" (4/7 interviewees)
**Intensity:** Medium

Initial setup is smooth. But when teams try to customize workflows (week 2-3), they hit complexity. The retained teams pushed through. The churned teams didn't.

> "Setting up was easy. Making it work the way WE work took forever." -- P2, Ops Lead

## Opportunity Tree

Day-90 Team Retention
|
+-- Opportunity 1: Teams need task updates flowing into Slack without manual effort
|   Evidence: 6/7 interviewees. Two strongest quotes from P1, P3.
|
+-- Opportunity 2: Champions need the tool to reduce their admin burden, not increase it
|   Evidence: 5/7 interviewees. Champion burnout is a churn predictor.
|
+-- Opportunity 3: Teams need guided workflow customization in weeks 2-3
|   Evidence: 4/7 interviewees. Retained teams got past this; churned didn't.

## Hypothesis Check

**Original hypothesis:** Integration gaps (Jira, Slack, GitHub) cause reversion.
**After research:** PARTIALLY CONFIRMED. Slack is critical (6/7). But Jira/GitHub are secondary. The real issue is broader: the tool doesn't embed into the team's communication layer (Slack) AND creates admin burden for the champion. Integrations are necessary but not sufficient.
```

---

## Mode 4: Package (`/product-discovery package`)

### Setup
- **Audience:** Executive (VP Product + CEO)
- **Recommendation:** GO

### Output: `discovery/day90-churn/one-pager.md` (excerpt)

```markdown
# Discovery One-Pager: Day-90 Team Churn

> Recommendation: **GO**

## The Problem

Mid-market teams (20-50 people) adopt our tool enthusiastically but disengage at week 6-8. 35% churn by day 90, putting ~$420K ARR at risk this quarter. The champion who brought the tool in burns out maintaining it, and without Slack integration, team members revert to their old workflow.

## The Evidence

| | |
|---|---|
| **Interviews conducted** | 7 project leads (3 churned, 2 at-risk, 2 retained) |
| **Core finding** | Churn is driven by Slack disconnection + champion burnout, not feature gaps |
| **Confidence level** | High -- pattern saturated at interview 5 |

### What We Heard

**"The Slack Gap"** (6/7 interviewees)
> "If it's not in Slack, it doesn't exist for my team." -- Engineering Lead

**"Champion Burnout"** (5/7 interviewees)
> "I became the [tool] guy. Nobody else knew how to set up a board." -- PM (churned)

## Recommendation: GO

Slack integration is not a nice-to-have -- it's the #1 driver of day-90 retention. Pair it with a champion support program (templates, onboarding checklist, week-2 setup wizard) to reduce admin burden. This addresses the two highest-priority opportunities from 7 interviews with high confidence.

### TLDR

1. **Problem:** Teams churn at day 90 because the tool doesn't embed into Slack and champions burn out
2. **Evidence:** 7 interviews, 6/7 cited Slack gap, 5/7 cited champion burnout
3. **Recommendation:** GO -- ship Slack integration + champion onboarding kit this quarter
```

---

## What Happened Next

The team shipped a Slack integration in 6 weeks. Day-90 churn dropped from 35% to 22% the following quarter. The champion onboarding kit (email sequence + setup wizard) reduced support tickets by 40%.

The PM ran the next discovery cycle on "Why do retained teams expand seats?" using the same 4-mode workflow.

---

*This example was generated by [discovery.md](https://github.com/mshadmanrahman/discovery-md) -- AI-powered product discovery for PMs.*
