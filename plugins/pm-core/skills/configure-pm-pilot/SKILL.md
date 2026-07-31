---
name: configure-pm-pilot
description: Interactive setup wizard for PM Pilot. Detects MCP tools, sets company name, creates memory template, validates installation.
origin: pm-pilot
version: 1.0.0
---

# Configure PM Pilot

Interactive setup wizard that configures PM Pilot for your environment.

## When to Activate

- User says "configure pm-pilot", "setup pm-pilot", or runs `/configure-pm-pilot`
- First-time installation
- After adding new MCP servers

## Step 1: Detect Available MCP Tools

Check which MCP servers are connected. These determine which skills work at full capacity.

| MCP Server | Skills It Powers |
|------------|-----------------|
| Atlassian (Jira/Confluence) | meeting-prep, weekly-status, deep-context, ask-company |
| Slack | meeting-prep, weekly-status, deep-context |
| GitHub | weekly-status, deep-context, search-first |
| Gmail/Calendar | meeting-prep |
| Playwright | dogfood |

Use `AskUserQuestion` to confirm detected tools and ask about any missing ones.

## Step 2: Configure Company Name

```
Question: "What's your company/org name? This configures the ask-company skill."
```

Update `skills/pm-core/ask-company/SKILL.md` with the company name in the Configuration section.

## Step 3: Create Memory File

If no MEMORY.md exists at the project level:
1. Copy `memory/MEMORY-TEMPLATE.md` to the appropriate location
2. Ask for 1-2 active projects to seed the Projects section
3. Ask for key people to seed the People section

```
Question: "What are you currently working on? (1-2 project names)"
Question: "Who are key stakeholders you work with? (name + role)"
```

## Step 4: Validate Installation

Check that all files are in place:
- Skills directory has 20 SKILL.md files
- Rules directory has 5 .md files
- Agents directory has 5 .md files
- Commands directory has 4 .md files

Report any missing files.

## Step 5: Summary

```
PM Pilot configured:
  MCP Tools: [list detected]
  Company: [name]
  Memory: [path to MEMORY.md]
  Skills: [count] active

  Try: "prep for my meeting" or "weekly status"
```
