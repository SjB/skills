---
name: pkm-curation
description: Curate an Obsidian vault — classify notes, normalize frontmatter, add wikilinks, extract atomic notes. Use when curating, batch-processing, reviewing, or doing a serendipity pick. 
---

# PKM Curation

Use this skill when working inside a Markdown-first vault that values curation over collection.

## Goals

- Turn raw notes into reusable atomic notes.
- Keep new notes consistent with vault conventions.
- Strengthen the link graph with meaningful `[[wikilinks]]`.
- Extract atomic notes from long or mixed-topic notes.

## Read This First

- Read `AGENTS.md` in the current repo scope before editing notes.
- Read `references/vault-conventions.md` when normalizing metadata, deciding note types, or choosing folders.
- Read `references/agent-integration.md` when running this skill through an agent.
- Keep changes small and reviewable.
- Keep file operations local to the vault unless the user explicitly asks otherwise.

## Search

```bash
# Search by filename
fd --type f ".md" "path/to/obsidian-vault" | rg -i "keyword"

# Search by content
rg -l "keyword" "path/to/obsidian-vault" --include "*.md"

# Find backlinks to a note
rg -l "\\[\\[Note Title\\]\\]" "path/to/obsidian-vault" --include "*.md"

# Find index notes
fd --type f "Index" "path/to/obsidian-vault"
```

## Rules

- Prefer curation over reorganization.
- Do not move, rename, or delete many notes at once unless the user asks.
- Do not invent links based only on shared words.
- Preserve the user's voice unless the user asks for a rewrite.
- Keep source material and evergreen ideas separate when possible.
- Treat `Inbox/` as temporary capture, not long-term storage.
- Preserve all command blocks, code snippets, configuration directives, and
  step-by-step instructions verbatim. Do not summarize or condense them.
- For reference/source notes: add a brief overview at the top, but keep the
  original commands and details intact below. Completeness > brevity.
- Read every file completely before moving, renaming, or modifying it. Do not rely on head/tail, heading-only scans, or partial reads to judge a file's content.

## Note-Type Heuristics

### Inbox note

Use when the note is raw capture, partial thinking, copied text, or an unprocessed link dump.

Actions:
- clean obvious structure issues
- add frontmatter if missing
- classify for later promotion
- avoid over-polishing unless requested

### Source note

Use when the note is based on an article, video, book, paper, transcript, or other external material.

Actions:
- keep source context intact
- summarize key takeaways
- extract reusable ideas into separate atomic notes
- link to related concepts and projects

### Atomic note

Use when the note captures one durable idea, concept, claim, pattern, or insight.

Actions:
- ensure one main idea per note
- make the title concept-focused
- add links to neighboring ideas
- keep it concise and self-contained

### Project note

Use when the note supports active work, planning, resources, decisions, or tasks.

Actions:
- preserve project context
- link tasks to the project note
- avoid turning active project logistics into evergreen notes unless there is a reusable insight

### Daily note

Use when the note is date-based and captures activity, learning, tasks, or reflection for a single day.

Actions:
- preserve chronology
- link out to durable notes rather than stuffing ideas into the daily note

## Linking Guidance

Add links only when they express one of these relationships:

- concept to broader concept
- source note to extracted idea
- project note to relevant knowledge note
- daily note to work done or ideas learned
- sibling concepts that genuinely inform one another

When linking, prefer existing notes over creating speculative new ones.

## Extraction Guidance

Extract atomic notes when a note contains:

- multiple durable ideas
- a strong claim hidden in raw notes
- a reusable method, distinction, or definition
- a concept that should be linked from many places

Keep extracted notes short. One note, one idea.

## Common Tasks

### Curate one note

1. Inspect the target note and locate its file in the vault.
2. Identify the note type: inbox, source, atomic, project, daily, or reference.
3. Normalize frontmatter and basic structure.
4. Clarify the title if vague or timestamp-like.
5. Tighten headings and summary; distill if it mixes too many ideas.
6. Inspect nearby related notes, then add a few strong `[[wikilinks]]`.
7. If the note contains multiple durable ideas, extract 1-3 atomic notes.
8. Suggest moving only if the destination is clearly better.
9. Patch the note in place and return a short summary of edits.

**Completion Criterion**: Note inspected, classified, normalized, linked, and patched, with a summary returned to the user.

### Curate an inbox batch

- process a small batch, usually 5-10 notes
- classify each note
- normalize metadata
- suggest which notes should stay raw, become source notes, or become atomic notes
- avoid large folder reshuffles unless the pattern is clear
- enumerate a small set of `Inbox/` notes
- process them one at a time
- stop and summarize after each batch

**Completion Criterion**: Each note in the batch classified and normalized, with a summary returned after the batch.

### Review recent notes

- inspect recently edited notes
- identify missing links and vague titles
- flag notes with mixed concerns
- suggest a small set of follow-up curation actions
- search by recent filenames or recent folders when file metadata is available
- keep edits conservative and return a review summary

**Completion Criterion**: Recently edited notes inspected, missing links and mixed concerns flagged, with a review summary returned.

### Serendipity review

- choose a note from the vault
- summarize it briefly
- compare it to the user's current topic or active project
- suggest only high-confidence connections
- pick one note from a user-specified folder or from curated folders only
- avoid randomizing across obviously raw capture unless the user asks for that

**Completion Criterion**: One curated note chosen, briefly summarized, compared to active topic, with only high-confidence connections suggested.

## Output Style

When responding to the user:

- state what kind of note you think it is
- summarize the curation changes you made or recommend
- list any extracted notes to create
- list meaningful links added or suggested
- mention any move or rename separately before doing it
- name the file or files touched
- separate completed edits from suggested next actions
- call out anything that still needs user confirmation

## If You Need More Context

If the vault structure is unclear, inspect folders and a few nearby notes before editing.
If note conventions appear to conflict, follow the most local `AGENTS.md` instructions in scope.
Don't guess at user preferences. When in doubt, ask the user before making big changes or suggesting speculative links.
