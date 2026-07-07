# Research Packet Template (OKF v0.1)

Use inside `Research/<YYYY-MM-DD> <Topic>/` unless the vault has a clearer convention.

The packet is an OKF bundle. See [vault-conventions.md](../../pkm-curation/references/vault-conventions.md) for the full frontmatter schema and type vocabulary.

## Bundle structure

```
Research/<YYYY-MM-DD> <Topic>/
├── index.md              # OKF progressive-disclosure, no frontmatter
├── log.md                # OKF chronological, datestamped entries (newest first)
├── Sources.md            # Research Source List
├── Synthesis.md          # Research Synthesis
├── Claims.md             # Research Claim Index
├── Questions.md          # Research Questions
├── Conversation.md       # Conversation Report
├── Glossaries.md         # Research Glossary
└── <atomic-note>.md      # Concept
```

### `index.md`

No frontmatter. Progressive-disclosure listing:

```markdown
# <Topic>

## Purpose
- Learning goal:
- Scope:
- Success criteria:

## Main Takeaways
-

## Packet Map
- [Sources](Sources.md) — compiled source list
- [Synthesis](Synthesis.md) — synthesized answer
- [Claims](Claims.md) — evidence-backed claims
- [Questions](Questions.md) — open and resolved questions
- [Conversation](Conversation.md) — raw conversation record
- [Glossaries](Glossaries.md) — term definitions
- [Log](Log.md) — session log

## Related Vault Notes
-

## Compiled Pages
| Page | Type | Purpose | Source basis | Status |
|---|---|---|---|---|
|  | source summary \| concept \| claim cluster \| synthesis \| promoted |  |  | draft \| reviewed \| promoted |

## Open Questions
-
```

### `log.md`

Datestamped entries, newest first. No frontmatter required (concept notes in the bundle DO need frontmatter, but log.md follows OKF §7 format).

```markdown
# Log

## YYYY-MM-DD
* **Event**: Description of what changed.
* **Files changed**: ...
```

### `Sources.md`

```markdown
---
type: Research Source List
title: <Topic> - Sources
description: Compiled source list for <Topic>.
tags: [research, sources]
timestamp: <ISO 8601>
id: <topic-slug>-sources
aliases: []
area: Research
project: ''
---

# Sources

| Source | Type | Why useful | Reliability notes | Accessed |
|---|---|---|---|---|
|  |  |  |  |  |

## Notes
-

## Raw Source Rules
- Preserve raw source files as immutable evidence.
- Add interpretation in packet notes, not inside the source file.
```

Include source links, books, papers, docs, videos, examples, search terms, or relevant vault notes only when they improve learning or evidence quality.

### `Synthesis.md`

```markdown
---
type: Research Synthesis
title: <Topic> - Synthesis
description: Compiled answer for <Topic> research.
tags: [research, synthesis]
timestamp: <ISO 8601>
id: <topic-slug>-synthesis
aliases: []
area: Research
project: ''
---

# Synthesis

## Short Answer

## Explanation

## Examples

## Disagreements or Uncertainty

## Practical Implications

## Links
-
```

### `Claims.md`

```markdown
---
type: Research Claim Index
title: <Topic> - Claims
description: Evidence-backed claims for <Topic> research.
tags: [research, claims]
timestamp: <ISO 8601>
id: <topic-slug>-claims
aliases: []
area: Research
project: ''
---

# Claims

## Claim: <single answerable claim>
- Type: source claim | synthesis | opinion | open question
- Evidence:
- Source:
- Confidence: high | medium | low
- Supports:
- Contradicts or complicates:
- Implications:
- Related notes:
- Last checked:
```

### `Questions.md`

```markdown
---
type: Research Questions
title: <Topic> - Questions
description: Open and resolved questions for <Topic> research.
tags: [research, questions]
timestamp: <ISO 8601>
id: <topic-slug>-questions
aliases: []
area: Research
project: ''
---

# Questions

## User Questions
-

## Open Questions
-

## Deferred or Out of Scope
-

## Follow-up Search Terms
-
```

### `Conversation.md`

```markdown
---
type: Conversation Report
title: <Topic> - Conversation
description: Narrative summary of the research conversation for <Topic>.
tags: [research, conversation]
timestamp: <ISO 8601>
id: <topic-slug>-conversation
aliases: []
area: Research
project: ''
---

# Conversation

## Learning Goal

## Assumptions

## Understanding Checks

## User Corrections

## Decisions

## Resources Shared
-
```

Record important answers, corrections, and scope decisions as the session progresses.

### `Glossaries.md`

```markdown
---
type: Research Glossary
title: <Topic> - Glossary
description: Term definitions for <Topic> research.
tags: [research, glossary]
timestamp: <ISO 8601>
id: <topic-slug>-glossary
aliases: []
area: Research
project: ''
---

# Glossaries

## <Term or Acronym>
- Expansion:
- Plain-language definition:
- Domain/context:
- Appeared in:
- Related links:
```

Add every acronym, abbreviation, domain-specific phrase, specialized term, jargon term, and domain nomenclature encountered.

## Atomic note

```markdown
---
type: Concept
title: <Concept Name>
description: <One-line summary of the concept>.
tags: [research, atomic-note, <topic-tag>]
timestamp: <ISO 8601>
id: <stable-id>
aliases: []
area: <area>
project: <packet topic>
---

# <Concept>

## Idea
<State the single reusable concept.>

## Why it matters
<Explain retrieval, decision, or learning value.>

## Evidence or source
- Claim: [Claims](Claims.md)
- Source:

## Links
- Broader:
- Related:
- Contrasts:

## Promotion status
- Packet-local | candidate for main vault | promoted to [path/to/promoted note](path/to/promoted.md)
```

## Linking

Use standard markdown links `[text](relative/path.md)` throughout. Do NOT use `[[wikilinks]]`. Intra-packet links are bundle-relative (e.g., `[Claims](Claims.md)`). Cross-bundle links use vault-relative paths.
