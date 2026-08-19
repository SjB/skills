---
name: conversation-summary
description: Save the current conversation as a comprehensive report note in your Obsidian vault, following OKF v0.1 conventions.
disable-model-invocation: true
---

Save this conversation as two linked files in your Obsidian vault: a report (the narrative) and a transcript (the raw conversation). The files live inside the `AI Conversation Summaries/` bundle and follow OKF v0.1 conventions.

## Report

Write a thorough, standalone report as a Markdown note. A rich narrative in prose, organized under natural headings that follow the conversation's own shape. Capture everything of substance:

- What prompted the conversation and what context was shared
- What was explored, investigated, or discussed in detail — including code, files, paths, URLs, tools, or skills that came up
- What was found, decided, agreed, or concluded
- Explanations given and concepts clarified
- Open questions or unresolved items

The report must be self-contained — someone reading it later should understand the full discussion, including the reasoning and all relevant details, without having been there. Err on the side of including too much detail rather than too little.

Include a link to the companion transcript where it fits naturally — a markdown link like `[transcript](2026-05-23_16-35_obsidian-summary-skill-upgrade_A7K2_transcript.md)` in the section where it makes the most sense (often near the end).

## Frontmatter

Both the report and the transcript use the merged OKF + vault frontmatter schema:

```yaml
---
type: Conversation Report         # report: Conversation Report, transcript: Conversation Transcript
title: <descriptive title>
description: <one-line summary>
tags: [conversation, <topic>]
timestamp: <ISO 8601 datetime>
id: <unique-slug>
aliases: []
area: <derived from conversation>
project: ''
---
```

## Bundle Awareness

`AI Conversation Summaries/` is an OKF bundle. After writing each new report/transcript pair:

1. Update `AI Conversation Summaries/index.md` — add an entry for the new report and transcript.
2. Append an entry to `AI Conversation Summaries/log.md` noting the addition.

## Transcript

Save the raw conversation as a separate Markdown note alongside the report. Keep it chronological with no editorializing. Redact likely credentials, secrets, tokens, and private keys.

## Location

Save both files to `AI Conversation Summaries/` under your vault root. Create the directory if needed. Never overwrite existing notes — if a filename collides, append a numeric suffix.

## Filenames

- Report: `YYYY-MM-DD_HH-mm_<topic-slug>.md`
- Transcript: `YYYY-MM-DD_HH-mm_<topic-slug>_transcript.md`

## Links

Use standard markdown links: `[text](relative/path.md)`. Do NOT use `[[wikilinks]]`.

Link the report to its transcript and vice versa using filenames:
- In report: `[transcript](YYYY-MM-DD_HH-mm_<topic-slug>_transcript.md)`
- In transcript: `[report](YYYY-MM-DD_HH-mm_<topic-slug>.md)`

## Safety

- Use only facts from the conversation. Do not invent references, decisions, or conclusions.
- Redact likely credentials, secrets, tokens, and private keys from any inline content.

## Done

Confirm both file paths and a one-sentence description of what the report covers. Also confirm that `AI Conversation Summaries/index.md` and `log.md` were updated.
