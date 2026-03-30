---
name: deep-context
description: |
  Cross-channel research on any topic. Searches all connected MCP tools in parallel, then synthesizes into a comprehensive briefing with timeline, status, stakeholders, and sources. Triggers on: "deep context", "tell me everything about", "research X", "full context on".
origin: pm-pilot
version: 1.0.0
---

# Deep Context

Comprehensive cross-channel research on any topic. Searches every connected tool in parallel, then synthesizes findings into a structured briefing. Use this when you need the full picture on a project, feature, incident, or initiative.

## When to Activate

- User says "deep context on X", "tell me everything about X"
- User says "research X", "full context on X", "what do we know about X"
- User needs to get up to speed on an unfamiliar topic quickly

## Input

Required:
- **Topic**: The subject to research (project name, feature, incident, concept, person)

Optional:
- **Time range**: How far back to search (default: 90 days)
- **Depth**: "quick" (summary only) or "deep" (full timeline + all sources, default)

## Execution

### Context Check
Before searching, read all four context files (`context/company.md`, `context/product.md`, `context/competitors.md`, `context/personas.md`) if they exist. Existing context informs search terms and avoids redundant research. After synthesis, offer to update context files with new knowledge discovered.

### Step 1: Expand Search Terms

Before searching, generate 3-5 related search terms. Topics often have aliases, abbreviations, or related concepts.

Example: "authentication redesign" expands to: "auth redesign", "login", "SSO", "identity", "auth v2"

### Step 2: Parallel Data Gathering (Fan-Out)

Search ALL connected MCP sources in parallel using each search term.

| Source | Method | What to Extract |
|:-------|:-------|:----------------|
| Jira | JQL text search | Epics, stories, bugs, comments mentioning topic |
| Confluence | CQL text search | Specs, RFCs, design docs, meeting notes |
| Slack | Message search across channels | Discussions, decisions, announcements |
| GitHub | Code search, issue search, PR search | Implementation details, technical decisions |
| Gmail | Thread search | Stakeholder communications |
| Google Calendar | Event search | Meetings related to topic |

### Step 3: Build Timeline

Order all findings chronologically. Identify:
- **Origin**: When did this topic first appear?
- **Key milestones**: Major decisions, launches, pivots
- **Current state**: Where things stand today
- **Stakeholders**: Who is involved and what role they play

### Step 4: Synthesize

Merge findings into a coherent narrative. Resolve contradictions by preferring more recent sources.

## Output Format

Output directly in conversation (do NOT create a file unless asked):

```markdown
# Deep Context: {Topic}
**Generated:** {date} | **Sources searched:** {count} | **Time range:** {range}

## Summary
{3-5 sentence executive summary of the topic: what it is, current status, key stakeholders}

## Timeline
| Date | Event | Source |
|:-----|:------|:-------|
| {date} | {First mention or kickoff} | {source} |
| {date} | {Key decision or milestone} | {source} |
| {date} | {Most recent activity} | {source} |

## Current Status
- **State:** {active/stalled/completed/planned}
- **Owner:** {person or team}
- **Next milestone:** {what's coming}
- **Blockers:** {if any}

## Stakeholders
| Person | Role | Last Activity |
|:-------|:-----|:-------------|
| {name} | {role in this topic} | {what they last did} |

## Key Documents
- {Document title} ({source + link}): {1-line description}

## Open Questions
- {Unresolved question found in discussions}
- {Decision that appears pending}

## Sources
{List every source consulted, whether it returned results or not}
```

## Rules

- **Exhaustive search**: Check every connected source. Do not skip any.
- **Cite everything**: Every claim links back to a specific source.
- **Chronological timeline**: Events ordered by date, not by source.
- **Surface contradictions**: If sources disagree, note it explicitly.
- **No speculation**: If something is unclear, list it under Open Questions.
- **Respect scope**: Stay focused on the topic. Related tangents go under a brief "Related Topics" note at the end.

## Fallback

If MCP tools are unavailable:
1. Note which sources were unreachable.
2. Use web search as a supplement for public topics.
3. Produce the briefing with whatever was found, clearly marking gaps.
