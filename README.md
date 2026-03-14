# PM Pilot

The product management toolkit for Claude Code. Built for PMs who code.

**20 skills, 5 rules, 5 agents, 4 slash commands.** Everything a technical PM needs to ship faster with AI.

## Install

```bash
# As a Claude Code plugin (recommended)
claude plugin install pm-pilot

# Or clone and configure manually
git clone https://github.com/mshadmanrahman/pm-pilot.git
cd pm-pilot
# Copy skills/rules/agents to your ~/.claude/ directory
```

## What's Inside

### PM Core Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| `meeting-prep` | "prep for my meeting with X" | Pulls context from Jira, Slack, Confluence, Calendar into a briefing |
| `weekly-status` | "weekly status" | Generates accomplishment report from connected systems |
| `deep-context` | "tell me everything about X" | Cross-channel research across all MCP tools |
| `market-sizing` | "size the market for X" | TAM/SAM/SOM analysis with data sources and assumptions |
| `ask-company` | "who owns X" | Enterprise knowledge assistant (configure for your org) |
| `dogfood` | "dogfood this app" | Systematic QA with Playwright: finds bugs, produces repro steps |
| `lenny-podcast` | "what does Lenny say about X" | Search 269+ PM podcast episodes for advice |

### Productivity Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| `session-init` | "resume" | Reads memory + handoffs to restore context |
| `handoff-doc` | "handoff" | Captures decisions, blockers, next steps for session continuity |
| `strategic-compact` | (proactive) | Suggests context compaction at logical milestones |
| `orchestrator` | "orchestrate" | Decomposes work into parallel waves of sub-agents |
| `manifest-reader` | "what did agents find" | Summarizes sub-agent results |
| `meta-observer` | "observe skills" | Tracks skill performance and emerging patterns |

### Dev Skills (for PMs who code)

| Skill | Trigger | What it does |
|-------|---------|--------------|
| `tdd-workflow` | writing new code | Enforces test-first development, 80%+ coverage |
| `verification-loop` | "verify" or before commits | Lint, type-check, test, security scan |
| `search-first` | before implementing | Research existing solutions before writing code |
| `security-review` | after writing auth/API code | OWASP checklist with severity ratings |

### Content Skills

| Skill | Trigger | What it does |
|-------|---------|--------------|
| `market-research` | "competitive analysis of X" | Source-attributed market and competitor research |
| `writing-style` | writing long-form content | Applies your configured voice profile to drafts |
| `writing-substack` | "write a Substack Note" | Platform-optimized short-form content |

### Slash Commands

| Command | What it does |
|---------|--------------|
| `/plan` | Create implementation plan, wait for approval before coding |
| `/code-review` | Review staged changes for quality, security, maintainability |
| `/verify` | Run full verification loop (lint + test + security) |
| `/tdd` | Enforce test-driven development for a feature |

### Agents

| Agent | Dispatched by | Purpose |
|-------|---------------|---------|
| planner | `/plan` | Phased implementation planning with risk analysis |
| code-reviewer | `/code-review` | Code quality and security review |
| build-error-resolver | build failures | Fix build errors with minimal diffs |
| tdd-guide | `/tdd` | Enforce RED-GREEN-REFACTOR cycle |
| file-analyzer | large file analysis | Summarize logs and verbose outputs |

## Setup

After installing, run the configuration wizard:

```
/configure-pm-pilot
```

This will:
1. Detect your available MCP tools (Jira, Slack, Confluence, etc.)
2. Set your company name for the `ask-company` skill
3. Create your initial `MEMORY.md` from the template
4. Validate that everything is connected

## Memory System

PM Pilot uses a file-based memory system that compounds learning across sessions:

```
memory/
  MEMORY.md          # Index file (always loaded, under 200 lines)
  project_*.md       # Project context
  user_*.md          # People context
  feedback_*.md      # Corrections and preferences
  reference_*.md     # Pointers to external systems
```

**The key insight:** MEMORY.md is always in context. Every session starts with full knowledge of your projects, people, and preferences. No re-explaining needed.

See `examples/` for populated examples.

## Session Workflow

```
MORNING
  Open Claude Code → MEMORY.md auto-loaded
  "Continue the matchmaker redesign" → full context from memory
  (or "read the latest handoff" → exact pickup from yesterday)

DURING SESSION
  Work normally
  Corrections saved as feedback memories
  New project info updates memory entries

END OF DAY
  "Create a handoff" → saves decisions + next steps
  Learnings saved to memory → next session starts smarter
```

## Rules (Token-Optimized)

Five compressed rules that load with every message (~600 tokens total):
- `coding-style.md` - Immutability, file organization, error handling
- `git-workflow.md` - Conventional commits, PR process
- `testing.md` - TDD, 80% coverage minimum
- `security.md` - Pre-commit security checklist
- `session-workflow.md` - Memory and learning protocol

## Customization

### Adding Your Company Knowledge

Edit `skills/pm-core/ask-company/SKILL.md` and configure:
- Your company name
- Available MCP tools (Confluence, Jira, Slack, etc.)
- Team structure and ownership areas

### Adding Your Writing Voice

Run the `writing-style` skill with 2-3 sample posts to extract your voice profile. The skill stores it and applies it to all future drafts.

### Adding Project-Specific Skills

Create a new skill directory:
```
skills/your-skill/SKILL.md
```

Follow the SKILL.md format from any existing skill as a template.

## Philosophy

1. **Memory over transcripts.** A 200-line MEMORY.md beats a 50K-token session replay.
2. **Skills load on demand.** 20 skills, zero startup cost.
3. **Rules are compressed.** 600 tokens, not 6,000.
4. **Research before coding.** Search first, build second.
5. **Every session compounds.** Corrections become rules. Patterns become skills.

## Contributing

PRs welcome. To add a skill:
1. Create `skills/category/your-skill/SKILL.md`
2. Follow the frontmatter format (name, description, origin, version)
3. Include clear triggers, step-by-step procedure, and output format
4. Keep under 200 lines

## License

MIT
