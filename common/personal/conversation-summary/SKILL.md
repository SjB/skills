---
name-: conversation-summary
description: Summarize the current AI conversation into a new Obsidian markdown note and matching transcript file. Use when the user asks to save, export, log, archive, or summarize the current chat into an Obsidian vault, research note, markdown note, meeting note, decision log, or second-brain workflow.
disable-model-invocation: true
---

Create exactly one new Obsidian summary note for the current conversation. Also create exactly one transcript note for the same conversation.

## Default location

- Write notes to `~/Documents/nca-notes/AI Conversation Summaries/` unless the user requests another path.
- Create the directory if it does not exist.
- Never overwrite an existing note.
- Never append to an existing note unless the user explicitly asks.

## Required behavior

1. Read the current conversation context only.
2. Generate a filesystem-safe title.
3. Write one summary note.
4. Write one transcript note.
5. Verify both files exist.
6. Return the exact paths, generated title, and count of action items captured.

## Title rules

Use this format:

`YYYY-MM-DD_HH-mm_<descriptor>_<ID>`

Rules:
- `<descriptor>`: 3-6 word slug based on the main topic.
- Allowed characters in the full title: letters, digits, `.`, `_`, `-`.
- Replace spaces with `-`.
- Remove other punctuation.
- Collapse repeated separators.
- `<ID>`: 4-character uppercase alphanumeric suffix.
- If a filename collision occurs, regenerate only `<ID>` until unique.
- If too long for the filesystem, shorten only `<descriptor>`.

## Obsidian-specific rules

- Use valid YAML frontmatter.
- Keep frontmatter simple and machine-safe.
- Use wikilink-friendly filenames.
- Include both standard markdown links and Obsidian wikilinks where useful.
- Keep headings shallow and scannable.
- Use UTF-8 markdown.
- Prefer stable tags in frontmatter plus inline hashtag tags at the end.
- If the conversation mentions files, URLs, papers, repos, tools, docs, or paths, capture them in a dedicated `References` section.
- If the conversation includes explicit choices, approvals, rejections, or resolved tradeoffs, capture them in `Decisions Made`.

## Summary quality rules

- Use only facts available in the current conversation.
- Do not invent references, decisions, action items, or conclusions.
- Do not write a play-by-play transcript in the summary note.
- Synthesize the conversation into a compact research/work summary.
- If information is missing, say so explicitly.
- If the conversation is short, still use the full template with fallback lines.
- If the transcript available to you is incomplete, mark it as partial.

## Automatic tags

Generate 4-8 tags total.

Always include:
- `ai-summary`
- one domain/topic tag based on the conversation
- one workflow tag based on the type of work, if clear

Add tags from these categories when supported by the conversation:
- domain: `research`, `coding`, `obsidian`, `automation`, `writing`, `planning`, `debugging`
- artifact: `skill`, `note`, `transcript`, `review`, `decision-log`
- status: `draft`, `completed`, `follow-up`
- technology/tool names in lowercase slug form when clearly central

Tag rules:
- Use lowercase kebab-case only.
- Prefer specific tags over generic ones.
- Do not add unsupported tags.

## References capture

In the `References` section, capture conversation-specific source material that was explicitly mentioned or used, such as:
- local file paths
- URLs
- repository paths
- document names
- tool names
- named skills, scripts, or commands

Format each reference as one bullet with a short label and what it was used for.

If none were mentioned, write:
- `- No explicit references or source artifacts captured.`

## Decisions capture

Capture only explicit decisions. Include items such as:
- accepted approach
- rejected alternative
- agreed file location
- approved implementation direction
- confirmed formatting preference

If none were made, write:
- `- No explicit decisions captured.`

## Transcript rules

- Save transcript in a separate file named `{{title}}_transcript.md`.
- Keep chronological order.
- Redact likely secrets or credentials.
- Add `[Transcript may be partial]` at the top if the available transcript is incomplete.
- Do not inline the full transcript inside the summary note.

## Summary note template

```md
---
id: {{title}}
aliases:
  - {{descriptor}}
  - {{short human title}}
tags:
  - ai-summary
  - {{tag1}}
  - {{tag2}}
  - {{tag3}}
created: {{ISO-8601 timestamp}}
source: current-ai-conversation
conversation_type: {{research|coding|planning|review|general}}
status: {{draft|completed|follow-up}}
---

# {{short human title}}

> [!abstract]
> **Created:** {{ISO-8601 timestamp}}
> **Source:** Current AI conversation
> **Main Topic:** {{one sentence, 8-20 words}}

## Research Question / Objective
{{One concise sentence. If none: `Not explicitly provided.`}}

## Summary
{{3-5 sentences synthesizing the main discussion, findings, constraints, and outcome. If none: `No meaningful summary could be derived beyond the limited conversation context.`}}

## Key Points
- {{3-7 concrete bullets}}

## Decisions Made
- {{explicit decision}}

## Action Items
- [ ] {{explicit next step}}

## Limitations / Unresolved Assumptions
- {{limitation or assumption}}

## Open Questions
- {{unresolved question}}

## References
- {{reference label}} — {{why it mattered}}

## Related Notes
- Transcript: [[{{title}}_transcript]]
- Markdown link: [{{title}}_transcript.md]({{title}}_transcript.md)

## Tags
#ai-summary {{inline_tags}}
```

## Transcript template

```md
[Transcript may be partial]

# {{short human title}} — Transcript

**Summary Note:** [[{{title}}]]
**Created:** {{ISO-8601 timestamp}}

{{verbatim conversation transcript with likely secrets redacted}}
```

If the transcript is complete, omit the `[Transcript may be partial]` line.

## Fallback lines

Use these exact fallbacks when needed:
- Decisions Made: `- No explicit decisions captured.`
- Action Items: `- [ ] No explicit action items identified.`
- Limitations / Unresolved Assumptions: `- No limitations or unresolved assumptions captured.`
- Open Questions: `- No open questions identified.`
- References: `- No explicit references or source artifacts captured.`

## File paths

- Summary: `~/Documents/nca-notes/AI Conversation Summaries/{{title}}.md`
- Transcript: `~/Documents/nca-notes/AI Conversation Summaries/{{title}}_transcript.md`

## Safety rules

- Never overwrite existing notes.
- Never fabricate transcript lines.
- Never fabricate references or decisions.
- Redact likely credentials, secrets, tokens, and private keys.
- If writing fails, return the full markdown for both files plus intended paths.
- If required context is unavailable, state that clearly in the note instead of guessing.

## Final response format

Confirm success with:
- summary file path
- transcript file path
- generated title
- number of action items captured
- tags generated
- number of references captured
- number of explicit decisions captured
