---
name: meeting-prep
description: |
  Pre-meeting context gathering across all connected systems. Pulls recent interactions, open items, and suggested talking points for any person or topic. Triggers on: "meeting prep", "prep for my meeting", "meeting with X", "prep for 1:1".
origin: pm-pilot
version: 1.0.0
---

# Meeting Prep

Gathers cross-channel context before any meeting so you walk in fully prepared. Works for person-based prep (1:1s) and topic-based prep (product syncs, reviews).

## When to Activate

- User says "meeting prep", "prep for my meeting with X", "prep for 1:1"
- User provides a person name or meeting topic to prepare for
- User says "what should I discuss with X?"

## Input

The user provides ONE of:
- **Person name**: e.g., "Sarah Chen", "Marco", "the CTO"
- **Topic/meeting name**: e.g., "Q3 planning", "API migration review"
- **Calendar event**: a specific meeting from today's calendar

If no input, check Google Calendar MCP for the next upcoming meeting and prep for that.

## Execution

### Context Check
Before gathering, read `context/company.md` and `context/personas.md` if they exist. Use for framing output. After completing the briefing, offer to update context files with any new knowledge about people, projects, or company priorities discovered during research.

### Step 0: Resolve Target

- Person name given: use as search target across all sources.
- Topic given: use as search query.
- No input: fetch next meeting from Google Calendar, extract attendees and title.

### Step 0.5: Org-Survival + People File Check (Person-Based Only)

Before gathering from external sources, read two local files:

1. **`memory/org-survival.md`** — Check if person has an entry. Extract: what they want, risks they carry, recommended approach. Surface as **Political Context** block (2–3 lines max). Skip silently if not found.

2. **`memory/people/{name}.md`** — Check for accumulated meeting history with this person. Extract: prior commitments they made (were they fulfilled?), communication style, known preferences. Fold into **Their Current Focus** and **Suggested Talking Points**.

This is the highest-signal step — it's the context no live API can replicate.

### Step 1: Parallel Data Gathering (Fan-Out)

Launch parallel searches across all connected MCP sources.

**For person-based prep:**

| Source | Query | Extract |
|:-------|:------|:--------|
| Google Calendar | Events with person in last 14 days | Meeting history, upcoming meetings |
| Jira | `assignee = "{person}" OR reporter = "{person}" AND updated >= -14d` | Active issues, recent updates |
| Slack | Search messages mentioning person | Recent conversations, open threads |
| Confluence | `contributor = "{person}" AND lastModified > now("-14d")` | Pages they edited recently |
| GitHub | PRs by author, issues assigned | Recent code activity |
| Gmail | Threads with person | Email conversations |

**For topic-based prep:**

| Source | Query | Extract |
|:-------|:------|:--------|
| Jira | `text ~ "{topic}" AND updated >= -30d` | Related tickets, status |
| Slack | Search channels and threads for topic | Recent discussions, decisions |
| Confluence | `text ~ "{topic}" AND lastModified > now("-30d")` | Specs, RFCs, documentation |
| GitHub | Search issues and PRs mentioning topic | Code changes, open PRs |
| Gmail | Search threads for topic | Email discussions |

### Step 2: Synthesize Prep Doc

Merge all results into the output format below. Deduplicate across sources. Prioritize recent items.

## Output Format

Output directly in conversation (do NOT create a file unless asked):

```markdown
# Meeting Prep: {Person or Topic}
**For:** {Meeting name if known} | **When:** {Time if known}

## Political Context _(person-based, if found in org-survival.md)_
- {What they want from this interaction}
- {Any risk or tension to navigate}
- {Recommended framing or approach}

## Last 3 Interactions
1. **{Date}** ({source}): {1-2 sentence summary}
2. **{Date}** ({source}): {1-2 sentence summary}
3. **{Date}** ({source}): {1-2 sentence summary}

## They're Waiting On You
- {Action item you owe them, with source}
(If none found: "Nothing outstanding found.")

## You're Waiting On Them
- {Action item they owe you, with source}
(If none found: "Nothing outstanding found.")

## Their Current Focus
- {What they're working on based on Jira/GitHub/Slack}

## Open Threads
- {Unresolved Slack threads or email chains}
- {Blocked Jira issues}

## Suggested Talking Points
1. {Based on open items and recent activity}
2. {Based on unresolved threads}
3. {Based on upcoming deadlines or decisions}
```

## Rules

- **Recency bias**: Prefer last 14 days for people, last 30 days for topics.
- **No speculation**: Only include items found in actual sources. Skip empty sections.
- **Cite sources**: Always note where information came from.
- **Keep it scannable**: Readable in 2 minutes before a meeting.
- **Respect privacy**: Only include conversations where the user is a participant.

## Fallback

If MCP tools are unavailable:
1. Note which sources were unreachable.
2. Produce the prep doc with whatever was found.
3. Suggest the user check those sources manually.
