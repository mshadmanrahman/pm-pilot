---
name: ask-company
description: |
  Enterprise knowledge assistant template. Searches Confluence, Jira, Slack, and internal docs to answer questions about your company. Users customize the company name, MCP sources, and team structure. Triggers on: "ask [company]", "who owns", "which team", "how does [thing] work".
origin: pm-pilot
version: 1.0.0
---

# Ask [Company]

Template for a company-specific knowledge assistant. Searches internal tools to answer questions about people, processes, ownership, architecture, and history.

## Configuration

Customize these values for your organization before use:

```yaml
company_name: "YourCompany"        # Replace with your company name
trigger_phrase: "ask yourcompany"   # Replace with your trigger

# MCP tools available (uncomment what you have connected)
sources:
  - confluence    # Wiki, specs, runbooks
  - jira          # Issues, epics, project tracking
  - slack         # Channel history, decisions
  # - github      # Repos, PRs, code search
  # - gmail       # Email threads
  # - notion      # Pages and databases
  # - linear      # Issues and projects

# Team structure (optional, improves routing)
teams:
  # - name: "Platform"
  #   keywords: ["infra", "deployment", "CI/CD", "kubernetes"]
  # - name: "Product"
  #   keywords: ["PRD", "roadmap", "feature", "user research"]
  # - name: "Data"
  #   keywords: ["analytics", "pipeline", "BigQuery", "metrics"]
```

## When to Activate

- User says "ask {company_name}", "who owns X", "which team handles X"
- User asks "how does X work here?", "what's our policy on X"
- User needs to find the right person, team, or document for something

## Input

A natural language question about the company. Examples:
- "Who owns the billing system?"
- "How does our deploy process work?"
- "What's the policy on on-call rotations?"
- "Which team should I talk to about search ranking?"

## Execution

### Step 1: Classify the Question

Determine the question type to optimize search strategy:

| Type | Examples | Primary Sources |
|:-----|:---------|:---------------|
| **Ownership** | "Who owns X?", "Which team?" | Confluence, Jira (component owners) |
| **Process** | "How does X work?" | Confluence (runbooks, docs), Slack (recent discussions) |
| **History** | "Why did we decide X?" | Slack (threads), Confluence (RFCs, ADRs) |
| **Status** | "Where is X at?" | Jira (epics, issues), GitHub (PRs) |
| **People** | "Who knows about X?" | Jira (assignees), Confluence (authors), Slack (active in topic) |

### Step 2: Expand Search Terms

Generate 3-5 search variations. Internal tools often use different terminology:
- Abbreviations and acronyms
- Project codenames vs official names
- Technical terms vs business terms

### Step 3: Parallel Search (Fan-Out)

Search all configured sources in parallel using expanded terms.

| Source | Method | What to Extract |
|:-------|:-------|:----------------|
| Confluence | CQL search | Relevant pages, runbooks, architecture docs |
| Jira | JQL search | Related epics, issues, component ownership |
| Slack | Message search | Recent discussions, decisions, announcements |
| GitHub | Code/issue search | Implementation details, READMEs |

### Step 4: Synthesize Answer

Combine findings into a direct answer. Prioritize:
1. Official documentation (Confluence) over informal (Slack)
2. Recent information over old
3. Authoritative sources (owners, leads) over general mentions

## Output Format

```markdown
## {Restated question as heading}

{Direct answer in 2-4 sentences}

### Key People
- **{Name}**: {Role in this context} ({source})

### Relevant Documents
- [{Document title}]({link}): {1-line description}

### Recent Activity
- {Date}: {What happened} ({source})

### Sources Searched
{List sources checked, including those that returned no results}
```

## Rules

- **Answer first**: Lead with the direct answer, then supporting evidence.
- **Cite sources**: Every fact links back to where it was found.
- **Admit gaps**: If the answer is incomplete, say what's missing and suggest who to ask.
- **Stay current**: Prefer recent sources. Flag if the best source is older than 6 months.
- **No guessing**: If you cannot find the answer, say so and suggest next steps (who to Slack, which channel to check).
- **Respect access**: Only surface information from tools the user has access to.

## Fallback

If the answer cannot be found:
1. State clearly: "I could not find a definitive answer."
2. List what was searched and what was found (even partial matches).
3. Suggest: "Try asking in #{relevant-channel}" or "Check with {likely owner}."
