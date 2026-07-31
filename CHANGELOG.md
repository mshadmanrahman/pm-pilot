# Changelog

All notable changes to PM Pilot are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
