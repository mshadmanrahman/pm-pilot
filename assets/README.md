# Assets

Static assets for the PM Pilot README and docs site.

## Files

- `hero.png` - Hero image used in the README header
- `terminal-structure.png` - Diagram showing terminal skill structure
- `demo.gif` - Animated terminal demo of the `meeting-prep` skill (generated)
- `demo.tape` - VHS tape script that generates `demo.gif`
- `demo-script.sh` - Shell script that simulates realistic meeting-prep output

## Generating the demo GIF

### Prerequisites

Install VHS (requires Go or Homebrew):

```bash
brew install vhs
```

VHS also requires `ttyd` and `ffmpeg` for GIF rendering:

```bash
brew install ttyd ffmpeg
```

### Generate

Run from the `assets/` directory:

```bash
cd assets && vhs demo.tape
```

This produces `assets/demo.gif`, which is embedded in the root README.

### What the GIF shows

A simulated terminal session of a PM using the `meeting-prep` skill in Claude Code.
The demo shows:

- Typing `prep for my 1:1 with Sarah`
- PM Pilot checking connected sources (Jira, Slack, Calendar)
- A formatted meeting brief with context pulled from those sources
- Suggested talking points surfaced automatically
- Total runtime ~13 seconds, loops cleanly in GitHub README

### Where the GIF is used

Embedded near the top of `/README.md` as the primary hero demo.
