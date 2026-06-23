---
name: research-vault
description: Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked Obsidian research packet.
disable-model-invocation: true
---

# Research Vault

Use when the user wants to learn or research a topic conversationally and save the outcome in an Obsidian vault.

## Packet

Create one vault folder per research run, normally `Research/<YYYY-MM-DD> <Topic>/`, containing all notes from the run: `Index.md`, `Sources.md`, `Synthesis.md`, `Claims.md`, `Questions.md`, `Conversation.md`, `Glossaries.md`, `Log.md`, and any atomic notes. Treat the packet as a Karpathy-style compiled wiki for the topic: raw sources stay immutable, packet notes are the maintained synthesis layer, and this skill is the schema. Load `references/research-packet-template.md` before writing packet files or when exact structure matters.

## Workflow

1. **Locate the vault.** Confirm the exact vault root and write only inside it.
2. **Frame the goal.** Ask one question at a time until you can restate the topic, learning objective, scope, and success criteria. Discover the user's goal, prior knowledge, intended use, depth, constraints, output preference, and trusted/distrusted sources only as needed.
3. **Create or defer the folder.** Create the packet folder once the topic has a stable working title; if still vague, keep conversing. Before writing durable notes, every artifact must have a path inside the packet folder.
4. **Map context.** Search the vault for the topic, synonyms, projects, and neighboring concepts. Read enough relevant notes to make meaningful links, not keyword matches.
5. **Ingest sources into claims.** For each source, preserve its path in `Sources.md`, extract evidence-backed claims into `Claims.md`, update affected concept/summary pages, and append an event to `Log.md`. Completion: every non-trivial factual claim has source, evidence, confidence, and at least one related link or explicit note that no link exists yet.
6. **Research and teach.** Answer the user directly from the compiled packet when possible, explain findings in small chunks, cite claims, preserve uncertainty, share resources when they improve learning or evidence quality, and correct misunderstandings before moving on.
7. **File good answers.** When a query produces a durable synthesis, decision, comparison, or explanation, add it back into `Synthesis.md`, `Claims.md`, or an atomic note instead of leaving it only in chat. Append the query and filed destination to `Log.md`.
8. **Check understanding and completeness.** Ask one diagnostic or completeness question per turn. Answer follow-ups with evidence, examples, counterarguments, implementation details, or resources as needed. Capture unresolved gaps in `Questions.md`.
9. **Write incrementally.** For long sessions, update `Conversation.md`, `Questions.md`, `Glossaries.md`, `Sources.md`, and `Log.md` as the work progresses. By the end, no research, teaching insight, user question, glossary term, source, or durable knowledge should exist only in chat.
10. **Lint the packet.** Before final report or promotion, check for unsupported claims, stale or contradictory claims, missing source links, orphan atomic notes, glossary terms without links, unanswered questions, and missing backlinks from `Index.md`. Record notable lint findings or fixes in `Log.md`.
11. **Promote reusable notes.** If a packet note becomes broadly useful beyond the run, propose promotion to the main vault, copy or move only with user approval, leave a provenance link in the packet, and update relevant indexes/MOCs.
12. **Report.** Summarize the packet path, files changed, links or backlink suggestions, top takeaways, what the user now understands, remaining questions, lint status, and promotion candidates.

## Conversation Rules

- Ask only one question per turn; if several details are missing, choose the most blocking one.
- Answer the user's question before asking another.
- If the user is uncertain, offer a small set of options and ask them to choose one.
- Use a teach-back loop for complex topics: plain-language explanation → concrete example → one check question or restatement prompt → correction → continue only when the user is satisfied or uncertainty is captured.
- Ask checks before research, after initial framing, after major findings, and before finalizing notes.
- When the user corrects you, record the correction in `Conversation.md`, update affected packet notes, and prefer the corrected framing unless later evidence contradicts it.
- Record important answers and useful resources in `Conversation.md`; reflect scope-changing details in `Index.md`, `Sources.md`, or `Synthesis.md`.

## Capture Rules

- Keep raw sources immutable: do not edit copied articles, PDFs, transcripts, or source exports except to add separate metadata notes.
- Distinguish source claims, agent synthesis, user opinions, and open questions with headings or labels.
- Write claims as answerable units, not vague topics: one sentence that can be supported, contradicted, or revised.
- For every claim, include evidence, source, confidence, implications, and related notes; use `low` confidence when provenance is weak or the claim is inferred.
- Prefer updating existing packet pages over creating duplicates; new sources should make the packet denser, not merely bigger.
- Put every acronym, abbreviation, domain-specific phrase, specialized term, jargon term, and piece of domain nomenclature in `Glossaries.md`, even when explained elsewhere.
- Keep sources, synthesis, claims, questions, conversation, glossary, and atomic knowledge separate.
- Keep citations close to claims; mark confidence when evidence is incomplete or contested.
- Preserve useful quotes verbatim with attribution.
- Distinguish source claims from interpretation; record failed searches or missing evidence when they affect the conclusion.
- Create atomic notes in the packet folder for durable concepts; link each from `Index.md` and back to its source or synthesis section.

## Retrieval Checks

Run these checks before treating the packet as complete:

- Could a future agent answer the user's main question from `Index.md`, `Synthesis.md`, and `Claims.md` without rereading raw sources?
- Does `Index.md` point to every durable packet page with enough context to choose the right page?
- Are important terms findable in `Glossaries.md` and linked from the pages that use them?
- Are contradictions, uncertainty, and missing evidence visible near the relevant claims?
- Does `Log.md` show the ingest/query/lint history well enough to reconstruct what changed and why?

## Linking Rules

Use Obsidian wikilinks: `[[Note Title]]` or `[[path/to/Note|alias]]`. Add links only when they explain context: broader concepts, projects, areas, MOCs, sources, authors, methods, tools, domains, supporting/refining/contradicting claims, or active problems. Do not link on shared words alone.
