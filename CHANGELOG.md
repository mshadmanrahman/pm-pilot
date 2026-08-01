# Changelog

All notable changes to PM Pilot are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.1.0] - 2026-08-01

### Added
- **Three repos folded in as plugins**, so there is one install surface instead of four separate repos:
  - `crucible` (was `mshadmanrahman/crucible`, 8 stars): 17-persona decision council. `personas.md` and `benches.md` are now bundled under `references/`.
  - `bug-shepherd` (was `mshadmanrahman/bug-shepherd`, 4 stars): 5 skills + the `reproduction-checker` agent. The 3 tracker adapters are bundled under `shepherd-sync/references/`.
  - `tech-to-pm` (was `mshadmanrahman/tech-to-pm-translator`, 5 stars): engineering docs into PM-readable context.
- Frontmatter added to the 5 bug-shepherd skills and the `reproduction-checker` agent, none of which had any.

### Fixed
- **Same dead-path class of bug as v2.0.0, in two more places.** `crucible` referenced `personas.md` and `benches.md` by bare filename, and bug-shepherd's commands pointed at `.claude/adapters/` and `.claude/agents/`, paths that only existed under the old manual-install layout. All now resolve to bundled `references/`, verified present in the installed plugin cache.

### Notes
- `ceremonies` and `morning-digest` were evaluated and **not** folded in. `ceremonies` is a 227-file Next.js application, not a skill. `morning-digest` is a 941-line Python script requiring the `gws` CLI, a Brave Search key, and a Telegram bot token, so it cannot work for anyone else without heavy setup.

---

## [2.0.0] - 2026-08-01

### Added
- **Plugin marketplace.** PM Pilot installs with one line: `claude plugin marketplace add mshadmanrahman/pm-pilot`. Five independent plugins: `pm-discovery`, `pm-core`, `pm-content`, `pm-dev`, `pm-productivity`.
- **`pm-discovery` plugin** with two new skills:
  - `interview-snapshot` turns one interview transcript into a structured five-section snapshot. Every direct quote is searched back against the source; unmatched quotes are labelled `[UNVERIFIED - edit before citing]` rather than silently repaired.
  - `product-discovery` runs the full cycle: frame, interview, synthesize, package. Absorbed from the now-archived `discovery-md` repo, with its four templates and worked example bundled as `references/` so they actually load.
- Hallucination guard and snapshot-first sequencing added to `synthesize-interviews`.
- Frontmatter added to the five agents and four commands that had none.

### Changed
- **Breaking:** skills, agents, and commands moved under `plugins/<plugin>/`. Skills are now namespaced when installed as plugins, so `/meeting-prep` becomes `/pm-core:meeting-prep`. Manual-copy users need to update their paths.
- `product-discovery` frontmatter dropped the unrecognized `version` and `author` fields and gained a trigger-rich description.

### Fixed
- `product-discovery` referred to four templates without ever giving a path, and the old install instructions copied only `SKILL.md`. Every template reference was dead on arrival. Templates are now bundled and referenced by path.

---

## [1.1.0] — 2026-04-05

### Added

- **`people-sync` skill** — Processes a Granola meeting transcript and updates per-person stakeholder files in `memory/people/`. Extracts positions, pushbacks, commitments, and questions per person. Tracks unresolved prior commitments across meetings. Chains naturally after any significant meeting.

- **`memory/org-survival-template.md`** — Power map template for key stakeholders. Captures what people actually want (not what they say they want), their risk patterns, and how to work with them effectively. Read automatically by `meeting-prep` for person-based prep.

- **`memory/judgment-log-template.md`** — Brier score prediction log. Log a PM judgment call before the outcome is known. Score it after `(confidence − actual)²`. Track whether your PM intuition sharpens over time.

- **`rules/pm-golden-rule.md`** — Enforces braindump-before-structure. Before any PRD, roadmap, strategy doc, OKR, or stakeholder one-pager: ask for the messy thinking first. Never open a template before the thinking is externalised.

### Upgraded

- **`meeting-prep` skill** — Added Step 0.5: reads `memory/org-survival.md` before any external API call. Surfaces a **Political Context** block (what they want, risks to navigate, recommended framing) at the top of the briefing. The highest-signal step — context no live API can replicate.

- **`CLAUDE.md`** — Added `people-sync` to PM Core skill list. Added Memory Templates section. Added PM Golden Rule section. Added "Thinking before templating. Braindump before structure." to Principles.

---

## [1.0.0] — 2026-03-15

Initial release.

- 24 PM skills across PM Core, Productivity, Dev, and Content categories
- Context flywheel: 4 persistent context files that grow through use
- Memory system with MEMORY.md index and typed memory files
- 5 agents: planner, code-reviewer, build-error-resolver, tdd-guide, file-analyzer
- 4 slash commands: /plan, /code-review, /verify, /tdd
- 5 token-compressed rules (~600 tokens total)
- Evidence tagging system: [Assumption], [Needs data], [Source: X], [Open question]
- Cross-platform support: macOS, Windows, Linux, VS Code, JetBrains
