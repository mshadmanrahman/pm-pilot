---
name: weekly-status
description: |
  Weekly accomplishment report. Pulls from Jira, GitHub, Confluence, and Slack to produce a structured status report with accomplishments, metrics, blockers, and next week plan. Triggers on: "weekly status", "status report", "what did I do this week".
origin: pm-pilot
version: 1.0.0
---

# Weekly Status

Generates a structured weekly accomplishment report by pulling activity from all connected work tools. Covers what got done, key metrics, blockers, and upcoming priorities.

## When to Activate

- User says "weekly status", "status report", "weekly update"
- User asks "what did I do this week?" or "what did I accomplish?"
- User needs to prepare for a standup, skip-level, or weekly sync

## Input

Optional overrides:
- **Date range**: Defaults to last 7 days. User can specify "last 2 weeks" or specific dates.
- **Focus area**: Limit to a specific project, team, or epic.
- **Audience**: "for my manager", "for the team", "for skip-level" (adjusts detail level).

## Execution

### Step 1: Determine Date Range

Default: 7 days back from today. Use the system `date` command to get the current date.

### Step 2: Parallel Data Gathering (Fan-Out)

Launch parallel searches across all connected MCP sources.

| Source | Query | Extract |
|:-------|:------|:--------|
| Jira | Issues transitioned to Done/Closed in date range, assigned to user | Completed work, story points |
| Jira | Issues currently In Progress, assigned to user | Active work |
| Jira | Issues with blockers or impediments | Blockers |
| GitHub | PRs merged by user in date range | Code shipped |
| GitHub | PRs opened and still in review | Pending reviews |
| Confluence | Pages created or updated by user in date range | Documentation work |
| Slack | Threads where user posted substantive messages | Key discussions, decisions |

### Step 3: Categorize and Synthesize

Group findings into categories:
- **Shipped**: Completed Jira issues, merged PRs, published docs
- **In Progress**: Active issues, open PRs
- **Blocked**: Issues with impediments, stalled PRs
- **Discussions**: Key decisions made in Slack/email

### Step 4: Generate Report

## Output Format

Output directly in conversation (do NOT create a file unless asked):

```markdown
# Weekly Status: {Date Range}

## Accomplishments
### Shipped
- {Completed item} ({source}: {link or ID})
- {Completed item} ({source}: {link or ID})

### Documentation
- {Page created/updated} ({Confluence link})

### Decisions Made
- {Decision}: {context} ({Slack channel or meeting})

## Metrics
- Issues completed: {count} ({story points} points)
- PRs merged: {count}
- Pages published: {count}

## In Progress
- {Active item}: {status/next step} ({source})

## Blockers
- {Blocker}: {what's needed to unblock} ({source})

## Next Week
- {Priority 1}: {brief description}
- {Priority 2}: {brief description}
- {Priority 3}: {brief description}
```

## Rules

- **Facts only**: Every line item must come from an actual source. No padding.
- **Cite sources**: Include Jira IDs, PR numbers, Confluence links.
- **Audience awareness**: If user specifies audience, adjust detail level. Manager reports are higher-level; team reports include technical detail.
- **Metrics matter**: Always include quantitative summary.
- **Next Week from backlog**: Pull upcoming priorities from Jira sprint or backlog, not invented.

## Fallback

If MCP tools are unavailable:
1. Note which sources were unreachable.
2. Ask the user to list accomplishments manually.
3. Help structure whatever they provide into the report format.
