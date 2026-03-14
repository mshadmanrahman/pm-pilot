# Writing Style

TEMPLATE for voice-consistent writing. Configure once, apply everywhere.

## Trigger
When writing long-form content (blog posts, articles, newsletters, LinkedIn posts).

## Voice Profile Setup

To configure your voice, provide 2-3 sample posts that represent your best writing. The skill extracts:

1. **Tone**: formal/casual/provocative/warm/authoritative
2. **Sentence patterns**: short and punchy vs. long and flowing, fragment usage, rhetorical questions
3. **Vocabulary**: technical depth, jargon level, signature phrases
4. **Structure**: how you open, transition, and close
5. **Perspective**: first person, second person, or mixed

### Setup Process

```
1. User provides 2-3 writing samples
2. Analyze each sample for the 5 dimensions above
3. Create voice profile (stored in memory)
4. Confirm profile with user before applying
```

### Voice Profile Format

```yaml
voice:
  tone: [e.g., "direct, warm, slightly irreverent"]
  sentences: [e.g., "short paragraphs, 1-3 sentences each, frequent fragments"]
  vocabulary: [e.g., "technical but accessible, avoids buzzwords, uses analogies"]
  structure: [e.g., "hook with bold claim, build with examples, end with actionable takeaway"]
  perspective: [e.g., "first person, speaks from experience"]
  avoid: [e.g., "em dashes, exclamation marks, corporate jargon"]
  signature: [e.g., "ends with a question to the reader"]
```

## Application Process

1. Load voice profile from memory.
2. Draft content following the requested format.
3. Self-review against all 5 dimensions.
4. Adjust any deviations before presenting.

## Rules
- Never override voice profile without explicit request.
- If no profile configured, ask for samples before writing.
- Flag when a requested format conflicts with the voice profile (e.g., formal voice + casual platform).
- Preserve the user's authentic voice. Enhance clarity, never change personality.
