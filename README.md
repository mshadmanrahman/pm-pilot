<p align="center">
  <img src="assets/hero.png" alt="PM Pilot  - The PM toolkit for Claude Code" width="720" />
</p>

<p align="center">
  <a href="https://github.com/mshadmanrahman/pm-pilot/stargazers"><img src="https://img.shields.io/github/stars/mshadmanrahman/pm-pilot?style=social" alt="GitHub stars" /></a>
</p>

<p align="center">
  <a href="https://github.com/mshadmanrahman/pm-pilot/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square" alt="MIT License" /></a>
  <a href="https://github.com/mshadmanrahman/pm-pilot/stargazers"><img src="https://img.shields.io/github/stars/mshadmanrahman/pm-pilot?style=flat-square" alt="Stars" /></a>
  <img src="https://img.shields.io/badge/claude_code-plugin-black?style=flat-square&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHJlY3Qgd2lkdGg9IjI0IiBoZWlnaHQ9IjI0IiByeD0iNCIgZmlsbD0iI2ZmZiIvPjwvc3ZnPg==" alt="Claude Code Plugin" />
  <img src="https://img.shields.io/badge/skills-25-orange?style=flat-square" alt="25 Skills" />
  <img src="https://img.shields.io/badge/agents-5-purple?style=flat-square" alt="5 Agents" />
</p>

<h2 align="center">Stop drowning in meeting prep, status updates, and Jira tickets.</h2>

<p align="center">
  Your AI product management co-pilot. Meeting briefings, PRDs, weekly status reports,<br/>
  stakeholder intel, market sizing - all from one place, in seconds instead of hours.
</p>

<p align="center">
  <img src="assets/demo.gif" alt="PM Pilot meeting prep demo" width="720" />
</p>

---

## Who is this for?

**You're a PM who's tried ChatGPT but nothing beyond that.** You paste meeting notes into it sometimes. Maybe you've used a company chatbot. But you keep thinking: there has to be a better way to handle all the prep, the status reports, the context-gathering that eats half your week. You just haven't found it yet. PM Pilot is that better way - and you don't need to be technical to start using it.

**You're a founder building your first product.** You're wearing every hat - product, design, sales, support. You don't have a PM background, and you don't have time to learn PM frameworks from scratch. You need something that gives you the structure and the thinking tools without the overhead. PM Pilot gives you battle-tested product management workflows, ready to go, so you can focus on building.

---

## Before and After

| The old way | With PM Pilot |
|---|---|
| 45 minutes prepping for a 1:1. Digging through Jira, Slack threads, email, trying to remember what Sarah committed to last time. | `prep for my 1:1 with Sarah` - full briefing with talking points, open commitments, and political context in 30 seconds. |
| Friday afternoon scramble. Piecing together your weekly status from memory, half-forgotten Slack messages, and browser history. | `weekly status` - accomplishment report generated from your actual completed tickets, merged PRs, and meeting outcomes. |
| Staring at a blank PRD template. You know the feature, but organizing the thinking feels like pulling teeth. | `write a PRD for [feature]` - PM Pilot asks for your messy thinking first, then structures it. Better docs because the thinking happens before the formatting. |
| Two hours of Googling for market data. Tab after tab. No consistent methodology. Numbers you're not confident presenting. | `size the market for [X]` - TAM/SAM/SOM analysis with clear assumptions, data sources, and methodology you can defend in a boardroom. |

---

## See it in action

```
prep for my meeting with Sarah
```
Pulls recent interactions from Jira, Slack, and Calendar. Surfaces what Sarah is working on, what you owe her, what she owes you, and three suggested talking points.

```
weekly status
```
Generates your accomplishment report from actual completed work. Not from memory - from connected systems.

```
write a PRD for [feature]
```
Asks for your messy thinking first. Then structures it into a one-pager, brief, full PRD, or RFC.

```
size the market for AI-powered PM tools
```
TAM/SAM/SOM with data sources and clear assumptions.

If this looks useful, [star this repo](https://github.com/mshadmanrahman/pm-pilot) so other PMs can find it too.

---

## Three ways to use PM Pilot (pick your comfort level)

You don't need to start with the terminal. PM Pilot meets you where you are.

### Level 1: Zero install - just copy and paste

**Best for:** Your first 10 minutes. No setup, no downloads.

Go to [claude.ai](https://claude.ai) (or ChatGPT). Paste the contents of any skill file from the [`skills/`](skills/) folder into your conversation. For example, paste the `meeting-prep` skill and then say "prep for my 1:1 with Sarah." The AI will walk you through it.

You won't get the Jira/Slack integrations at this level, but you'll instantly see the structured thinking PM Pilot brings to your workflow.

**Start here:** Open [`skills/pm-core/meeting-prep/SKILL.md`](skills/pm-core/meeting-prep/SKILL.md) and paste it into claude.ai.

### Level 2: Claude Desktop app (5-minute setup, visual interface)

**Best for:** PMs who want the full skill library without touching a terminal.

1. Download the [Claude Desktop app](https://claude.ai/download)
2. Drop the PM Pilot skill files into your Claude Desktop configuration
3. Start using skills by name: "prep for my meeting with Sarah"

This gives you persistent memory between sessions and access to all 25 skills through a friendly chat interface.

### Level 3: Full power with Claude Code (terminal + integrations)

**Best for:** PMs who want PM Pilot connected to Jira, Slack, Calendar, and GitHub - pulling real data, not just templates.

This is where PM Pilot shines. Claude Code is a command-line tool (you type commands in a terminal window, like the one built into VS Code). It connects directly to your work tools through plugins called MCP servers.

> **New to Claude Code entirely?** Start at [claudecodeguide.dev](https://claudecodeguide.dev) first. It's a friendly, jargon-free guide that gets you set up in under an hour. Come back here once you're running.

#### Quick install

```bash
# Clone PM Pilot
git clone https://github.com/mshadmanrahman/pm-pilot.git
cd pm-pilot

# Create the directories Claude Code looks in
mkdir -p ~/.claude/skills ~/.claude/rules ~/.claude/agents ~/.claude/commands ~/.claude/memory

# Copy everything into place
cp -r skills/* ~/.claude/skills/
cp -r rules/* ~/.claude/rules/
cp -r agents/* ~/.claude/agents/
cp -r commands/* ~/.claude/commands/

# Set up your memory file (this is where Claude remembers things about you)
cp memory/MEMORY-TEMPLATE.md ~/.claude/memory/MEMORY.md
```

Don't have `git`? [Download it here](https://git-scm.com/downloads).

Then open Claude Code in any directory and run the setup wizard:

```
/configure-pm-pilot
```

It asks a few questions (your company name, which tools you use) and configures everything automatically.

---

## Connecting your work tools (Level 3 only)

PM Pilot works immediately. But it gets dramatically more useful when Claude Code can see your actual work tools. You connect these through **MCP servers** - think of them as plugins that let Claude read from Jira, Slack, and more.

| Tool | What it unlocks | How to add |
|------|----------------|------------|
| **Jira / Confluence** | meeting-prep, weekly-status, deep-context | [Atlassian MCP](https://github.com/sooperset/mcp-atlassian) |
| **Slack** | meeting-prep, weekly-status, deep-context | [Slack MCP](https://github.com/modelcontextprotocol/servers/tree/main/src/slack) |
| **Google Calendar** | meeting-prep (knows your schedule) | [GCal MCP](https://github.com/nspady/google-calendar-mcp) |
| **GitHub** | weekly-status, code context | [GitHub MCP](https://github.com/modelcontextprotocol/servers/tree/main/src/github) |
| **Granola** | people-sync (updates stakeholder files from meeting transcripts) | [Granola MCP](https://granola.ai) |

**No MCP servers connected?** Skills like `market-sizing`, `prd`, `prioritize`, `critique`, `writing-style`, and `tdd-workflow` work with zero external connections. Start there and add integrations as you go.

---

## Top 5 things you'll do in your first week

### 1. Prep for a meeting in 30 seconds
```
prep for my 1:1 with Sarah
```
Pulls context from every connected source. Surfaces open commitments, recent work, talking points, and political context from your org survival map. Even without integrations, it structures your thinking and gives you a framework.

### 2. Generate your weekly status report
```
weekly status
```
No more Friday afternoon scramble. This pulls from actual completed tickets, merged PRs, and meeting outcomes - then writes your accomplishment report ready to paste into email or Slack.

### 3. Write a PRD that actually reflects your thinking
```
write a PRD for [feature]
```
PM Pilot won't open a blank template. It asks you to dump your messy, unstructured thinking first. The contradictions, the unknowns, the things you're avoiding. Then it structures everything into a clean document. You get better docs because the thinking happens before the formatting.

### 4. Size a market with real methodology
```
size the market for [X]
```
TAM/SAM/SOM analysis with clear assumptions, data sources, and methodology. The kind of output you can put in front of a VP or investor without hedging.

### 5. Build a deep context brief on anything
```
tell me everything about Project X
```
Cross-channel research across all your connected tools. Jira tickets, Slack conversations, Confluence pages, meeting notes - synthesized into one brief. Perfect for when you inherit a project or need to get smart on something fast.

Want the full list of all 25 skills? See the [complete skill reference](#full-skill-reference) at the bottom.

---

## How the memory system works

Claude forgets everything between sessions by default. PM Pilot fixes this with a structured memory system - a set of files Claude reads at the start of every session.

```
~/.claude/memory/
  MEMORY.md              - always loaded, under 200 lines - your current projects and people
  project_*.md           - one file per project you own
  feedback_*.md          - corrections you've made (so Claude doesn't repeat mistakes)
  user_*.md              - your preferences and working style
  people/                - one file per key person (grows after every meeting)
    sarah-chen.md
    marco-vidal.md
```

**Day 1:** Memory is empty. You explain your projects once.
**Day 5:** Memory has your projects, people, and preferences. Much less explaining.
**Day 15:** Patterns and lessons saved. Almost zero re-explaining.
**Day 30:** New sessions start with full context. You just say what to do.

The key insight: every correction you make gets saved. You tell Claude something once - it doesn't repeat the same mistake.

### Optional power files

Two files that compound over time. Copy from the templates to activate:

| File | What it does |
|------|-------------|
| `memory/org-survival-template.md` | Power map of key stakeholders: what they actually want, their risk patterns, how to approach them. Read automatically by `meeting-prep`. |
| `memory/judgment-log-template.md` | Track PM judgment calls with Brier scores before the outcome is known. Watch your calibration improve over time. |

```bash
cp memory/org-survival-template.md ~/.claude/memory/org-survival.md
cp memory/judgment-log-template.md ~/.claude/memory/judgment-log.md
```

---

## Why this exists

PMs spend 60% of their time on status updates, meeting prep, and context-gathering. Not on product thinking. Not on strategy. Not on the work that actually moves the needle.

PM Pilot gives you that time back.

It started as one PM's personal setup - 14 years of product experience across startups and enterprise, distilled into a set of reusable skills and workflows. The kind of system you'd build for yourself if you had the time. Now you don't have to.

This isn't another AI wrapper or SaaS tool. It's pure markdown files. No vendor lock-in, no subscription beyond what you already pay for Claude. You own it, you can read every line, and you can change anything that doesn't fit your workflow.

Five principles behind the design:

1. **Braindump before structure.** Never open a template before the thinking is externalized.
2. **Memory over transcripts.** A 200-line memory file beats a 50,000-token session replay.
3. **Skills load on demand.** 25 skills, zero startup cost.
4. **Rules are compressed.** ~950 tokens total, not 9,500.
5. **Every session compounds.** Corrections become rules. Meetings become stakeholder intelligence.

---

<details>
<summary><h2>Full skill reference (25 skills, 5 agents, 4 slash commands)</h2></summary>

### PM Core

| Skill | How to trigger it | What it does |
|-------|------------------|--------------|
| `meeting-prep` | "prep for my meeting with X" | Briefing from Jira, Slack, Calendar + political context from your org survival map |
| `people-sync` | "sync people from meeting" | Reads Granola transcript, updates per-person stakeholder files with positions, pushbacks, commitments |
| `weekly-status` | "weekly status" | Accomplishment report from connected systems - not from memory |
| `deep-context` | "tell me everything about X" | Cross-channel research across all connected tools |
| `market-sizing` | "size the market for X" | TAM/SAM/SOM with data sources and clear assumptions |
| `ask-company` | "who owns X at my company" | Enterprise knowledge assistant (configure for your org) |
| `dogfood` | "dogfood this app" | Systematic QA with bug reports and repro steps |
| `lenny-podcast` | "what does Lenny say about X" | Search 269+ PM podcast episodes for relevant advice |
| `prd` | "write a PRD for X" | Braindump first, then structure: one-pagers, briefs, full PRDs, or RFCs |
| `prioritize` | "rank these features" | Score with RICE, ICE, WSJF, MoSCoW, Kano, or Value/Effort |
| `synthesize-interviews` | "synthesize these interviews" | Themes, pain points, and recommendations from raw interview notes |
| `critique` | "critique this doc" | Pressure-test any document for logic gaps, assumptions, and completeness |

### Productivity

| Skill | How to trigger it | What it does |
|-------|------------------|--------------|
| `session-init` | "resume" or start of day | Reads memory and handoffs to restore context - no cold starts |
| `handoff-doc` | "create a handoff" | Captures decisions, blockers, and next steps for session continuity |
| `strategic-compact` | (proactive) | Suggests context compaction at logical milestones |
| `orchestrator` | "orchestrate this" | Decomposes complex work into parallel sub-agent waves |
| `manifest-reader` | "what did agents find" | Summarizes results from sub-agent research |
| `meta-observer` | "observe my skills" | Tracks skill performance and emerging workflow patterns |

### Dev (for PMs who write code)

| Skill | How to trigger it | What it does |
|-------|------------------|--------------|
| `tdd-workflow` | when writing new code | Enforces test-first development: RED, GREEN, REFACTOR |
| `verification-loop` | "verify" or before commits | Lint, type-check, test, security scan in sequence |
| `search-first` | before implementing anything | Research existing solutions before writing new code |
| `security-review` | after writing auth or API code | OWASP checklist with severity ratings |

### Content

| Skill | How to trigger it | What it does |
|-------|------------------|--------------|
| `market-research` | "competitive analysis of X" | Source-attributed market and competitor research |
| `writing-style` | writing long-form content | Applies your voice profile to drafts |
| `writing-substack` | "write a Substack Note" | Platform-optimized short-form content |

### Slash commands

| Command | What it does |
|---------|--------------|
| `/plan` | Create implementation plan, wait for approval before coding |
| `/code-review` | Review staged changes for quality, security, maintainability |
| `/verify` | Full verification: lint + test + security |
| `/tdd` | Enforce test-driven development for a feature |

### Agents

| Agent | What it does |
|-------|--------------|
| `planner` | Phased implementation planning with risk analysis |
| `code-reviewer` | Code quality and security review |
| `build-error-resolver` | Fix build errors with minimal diffs |
| `tdd-guide` | Enforce RED-GREEN-REFACTOR cycle |
| `file-analyzer` | Summarize logs and verbose outputs |

</details>

---

## Troubleshooting

### "Skills not showing up"

Skills need to be in the right directory. Check:

```bash
ls ~/.claude/skills/pm-core/meeting-prep/SKILL.md
```

If missing, re-run the copy commands from the install section. Restart Claude Code after.

### "meeting-prep returns nothing useful"

This skill pulls from connected tools (Jira, Slack, Calendar). If none are connected, it will tell you what's missing and do its best with what's available. Add MCP servers to unlock the full briefing.

### "Memory not loading between sessions"

MEMORY.md needs to be in a location Claude Code auto-loads:
- Works everywhere: `~/.claude/memory/MEMORY.md`
- Works in one project: `.claude/memory/MEMORY.md` in your project root

### "Context filling up too fast"

PM Pilot's rules use only ~950 tokens total - they're not the culprit. If sessions are filling up:
1. Use `strategic-compact` to compact at natural milestones
2. Use `handoff-doc` to save state, then `/clear` to start fresh
3. Use `orchestrator` to move research into sub-agents

---

## Part of the PM Toolkit Family

| Tool | What it does |
|------|-------------|
| **PM Pilot** | **You are here** - Claude Code configured for PMs |
| [Discovery](https://github.com/mshadmanrahman/discovery-md) | AI product discovery for PMs |
| [Bug Shepherd](https://github.com/mshadmanrahman/bug-shepherd) | Zero-code bug triage with parallel AI agents |
| [Tech-to-PM Translator](https://github.com/mshadmanrahman/tech-to-pm-translator) | Convert developer docs into PM-friendly knowledge bases |
| [Morning Digest](https://github.com/mshadmanrahman/morning-digest) | AI-powered daily briefing from calendar, email, and Slack |
| [ROOT-KG](https://github.com/mshadmanrahman/root-kg) | Your knowledge graph. Ask questions across all your notes, meetings, and emails |
| [Ceremonies](https://github.com/mshadmanrahman/ceremonies) | Agile ceremonies that don't suck |
| [Riff](https://github.com/mshadmanrahman/riff) | LinkedIn engagement assistant for AI-drafted replies |
| [Claude Code Guide](https://claudecodeguide.dev) | Friendly guide to Claude Code for absolute beginners |

---

## Contributing

PRs welcome. To add a skill:
1. Create `skills/category/your-skill/SKILL.md`
2. Follow the frontmatter format (name, description, origin, version) from any existing skill
3. Include: clear triggers, step-by-step procedure, output format
4. Keep under 200 lines

## License

MIT

---

*Built by a PM with 14 years of product experience across startups and enterprise. 83 unique cloners in 2 weeks. Pure markdown, no build step, no dependencies.*
