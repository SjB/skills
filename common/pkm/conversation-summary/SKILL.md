---
name: conversation-summary
description: Save the current conversation as a comprehensive report note in your Obsidian vault.
disable-model-invocation: true
---

Save this conversation as two linked files in your Obsidian vault: a report (the narrative) and a transcript (the raw conversation).

## Report

Write a thorough, standalone report as a Markdown note. A rich narrative in prose, organized under natural headings that follow the conversation's own shape. Capture everything of substance:

- What prompted the conversation and what context was shared
- What was explored, investigated, or discussed in detail — including code, files, paths, URLs, tools, or skills that came up
- What was found, decided, agreed, or concluded
- Explanations given and concepts clarified
- Open questions or unresolved items

The report must be self-contained — someone reading it later should understand the full discussion, including the reasoning and all relevant details, without having been there. Err on the side of including too much detail rather than too little.

Include a link to the companion transcript where it fits naturally — an Obsidian wikilink like `[[{{title}}_transcript]]` in the section where it makes the most sense (often near the end).

## Transcript

Save the raw conversation as a separate Markdown note alongside the report. Keep it chronological with no editorializing. Redact likely credentials, secrets, tokens, and private keys.

## Location

Save both files to `AI Conversation Summaries/` under your vault root. Create the directory if needed. Never overwrite existing notes — if a filename collides, append a numeric suffix.

## Filenames

- Report: `YYYY-MM-DD_HH-mm_<topic-slug>.md`
- Transcript: `YYYY-MM-DD_HH-mm_<topic-slug>_transcript.md`

## Safety

- Use only facts from the conversation. Do not invent references, decisions, or conclusions.
- Redact likely credentials, secrets, tokens, and private keys from any inline content.

## Done

Confirm both file paths and a one-sentence description of what the report covers.
