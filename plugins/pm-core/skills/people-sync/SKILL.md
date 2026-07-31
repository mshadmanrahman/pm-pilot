---
name: people-sync
description: |
  Pulls a Granola meeting transcript and updates people files with per-person intelligence: what they said, what they pushed back on, what they committed to. Compounds over time — each meeting adds a layer. Triggers on: "sync people", "update people from meeting", "update stakeholders", "/people-sync".
origin: pm-pilot
version: 1.0.0
---

# People Sync Skill

Processes a Granola meeting and appends per-person intelligence to people files in `memory/people/`. Unlike `/post-meeting` (which is project-focused), this skill is **people-focused** — it builds stakeholder profiles from real conversations that compound across every session.

## When to Activate

- User says `/people-sync`
- User says "sync people from meeting", "update stakeholder files"
- Naturally chains after `/post-meeting` for full meeting coverage

## People File Location

```
memory/people/{firstname}-{lastname}.md
```

Naming: lowercase, hyphens. Example: `memory/people/sarah-chen.md`

## Execution

### Step 0: Get the Meeting

```
1. If user gave a topic/person:
   → mcp__claude_ai_Granola__query_granola_meetings with the search term
   → Pick the most recent match

2. If user gave nothing:
   → mcp__claude_ai_Granola__list_meetings (last 5)
   → Present list, ask user to pick one

3. Once identified:
   → mcp__claude_ai_Granola__get_meeting_transcript for full content
```

### Step 1: Extract Participants

Get all participants from the transcript. For each person (excluding the user themselves):
1. Check if a `memory/people/{name}.md` file exists
2. Flag unmatched participants — ask if a new file should be created

### Step 2: Per-Person Extraction

For each matched participant, extract from transcript:

| Signal | What to look for |
|:-------|:-----------------|
| **Positions** | Views, preferences, priorities stated clearly |
| **Pushbacks** | Disagreements, concerns, hesitation, resistance |
| **Commitments** | What they said they'd do, by when |
| **Questions asked** | Reveals what they care about or what's unclear to them |
| **Communication style** | Terse? Verbose? Direct? Diplomatic? (only note if new/notable) |

**Attribution rules:**
- Only record things clearly attributable to the person
- If ambiguous, skip — false intelligence is worse than no intelligence
- Granola's `action_items` can supplement but always verify against full transcript

### Step 3: Read Existing File

Before appending, read the existing people file to:
- Avoid duplicating already-captured information
- Check if prior commitments from past meetings were fulfilled

### Step 4: Append Meeting Entry

Append to `## Meeting History` section (create it if absent):

```markdown
## Meeting History

### {Meeting Title} — {YYYY-MM-DD}

**Positions:** {what they advocated for}
**Pushbacks:** {concerns or resistance raised}
**Commitments:** {what they said they'd do, with dates if mentioned}
**Style note:** {optional — only if something new/notable}
```

Omit any line with nothing to record. Don't write "Pushbacks: none."

**Commitment tracking:** If a prior commitment appears unresolved, note it:
```markdown
⚠️ Unresolved from {prior date}: "{commitment}" — not mentioned in this meeting
```

### Step 5: New Person File

If creating a new file for an unmatched participant:

```markdown
---
name: {Full Name}
role: {Title / Company / Relationship}
---

{Full Name} — {role, relationship to user}.

{2-3 sentences of context: what they own, what their priorities are}

**How to work with them:** {key insight for future interactions}

## Meeting History

### {Meeting Title} — {YYYY-MM-DD}

{first entry}
```

### Step 6: Report Back

```
✅ Updated {N} people files from "{Meeting Title}" ({date})

→ Sarah Chen: 1 commitment (share specs by Friday), pushed back on timeline
→ Marco Vidal: asked about pricing model — reveals cost sensitivity
→ Nina Johansson: quiet — no strong signals

⚠️ 1 unmatched participant: "Jordan K" — create a new file?
```

## Rules

- **Append-only**: Never overwrite past entries. Add, don't replace.
- **Commitment tracking is the compounding value**: Flag unresolved past commitments.
- **Quality over quantity**: 3 accurate signals beat 10 vague ones.

## Chaining with /post-meeting

Run both after any significant meeting:
- `/post-meeting` → updates what happened to the **project**
- `/people-sync` → updates what you learned about the **people**
