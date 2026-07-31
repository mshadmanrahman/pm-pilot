# Contributing to PM Pilot

PM Pilot is a toolkit built by a PM, for PMs. Contributions that make product management easier with Claude Code are welcome.

## Ways to Contribute

### New Skills
The most impactful contribution. A skill is a markdown file that teaches Claude Code a new capability. See `plugins/*/skills/` for examples.

A good PM Pilot skill:
- Solves a real PM pain point (not a theoretical one)
- Works without code knowledge where possible
- Loads on demand (triggered by specific phrases)
- Uses MCP servers for external data when available

### Improved Agents
Agents in `plugins/*/agents/` handle specialized tasks. If you've found a better pattern for code review, testing, or analysis, share it.

### Better Rules
Rules in `rules/` enforce quality standards. If you have coding standards or workflow rules that help PMs, contribute them.

### Documentation
Clearer installation guides, better examples, or workflow documentation.

## How to Submit

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature`
3. Add your skill/agent/rule
4. Update README.md if adding a new skill (add to the appropriate category table)
5. Submit a PR describing what it does and why it's useful

## Style Guide

- Write for PMs first, developers second
- Keep skills focused: one skill, one job
- Include trigger phrases so the skill activates naturally
- Test with Claude Code before submitting

## Related Projects

- [Bug Shepherd](https://github.com/mshadmanrahman/bug-shepherd) — Zero-code bug triage system (companion project)
