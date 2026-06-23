# Research Packet Template

Use inside `Research/<YYYY-MM-DD> <Topic>/` unless the vault has a clearer convention.

## Required files

### `Index.md`

```markdown
# <Topic>

## Purpose
- Learning goal:
- Scope:
- Success criteria:

## Main Takeaways
-

## Packet Map
- [[Sources]]
- [[Synthesis]]
- [[Claims]]
- [[Questions]]
- [[Conversation]]
- [[Glossaries]]
- [[Log]]

## Related Vault Notes
-

## Compiled Pages
| Page | Type | One-line purpose | Source basis | Status |
|---|---|---|---|---|
|  | source summary \| concept \| claim cluster \| synthesis \| promoted |  |  | draft \| reviewed \| promoted |

## Open Questions
-
```

### `Sources.md`

```markdown
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

### `Log.md`

```markdown
# Log

Append one entry for each ingest, query filed back into the packet, lint pass, promotion, or major correction.

## YYYY-MM-DD HH:MM — <ingest | query | lint | promotion | correction>
- Input:
- Files read:
- Files changed:
- Claims added or revised:
- Links added:
- Open issues:
```

### `Glossaries.md`

```markdown
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
id: <stable-id>
aliases: []
tags: [research, atomic-note]
area: <area>
project: [[<packet topic>]]
---
# <Concept>

## Idea
<State the single reusable concept.>

## Why it matters
<Explain retrieval, decision, or learning value.>

## Evidence or source
- Claim: [[Claims#Claim <anchor or short title>]]
- Source:

## Links
- Broader:
- Related:
- Contrasts:

## Promotion status
- Packet-local | candidate for main vault | promoted to [[path/to/promoted note]]
```
