---
name: research-vault
description: Research a topic through a one-question-at-a-time learning conversation, answer directly, share resources when useful, and save a linked Obsidian research packet.
disable-model-invocation: true
---

# Research Vault

Use when the user wants to learn or research a topic conversationally and save the outcome in an Obsidian vault.

## Packet

Create one vault folder per research run, normally `Research/<YYYY-MM-DD> <Topic>/`, containing all notes from the run: `Index.md`, `Sources.md`, `Synthesis.md`, `Claims.md`, `Questions.md`, `Conversation.md`, `Glossaries.md`, and any atomic notes. Load `references/research-packet-template.md` before writing packet files or when exact structure matters.

## Workflow

1. **Locate the vault.** Confirm the exact vault root and write only inside it.
2. **Frame the goal.** Ask one question at a time until you can restate the topic, learning objective, scope, and success criteria. Discover the user's goal, prior knowledge, intended use, depth, constraints, output preference, and trusted/distrusted sources only as needed.
3. **Create or defer the folder.** Create the packet folder once the topic has a stable working title; if still vague, keep conversing. Before writing durable notes, every artifact must have a path inside the packet folder.
4. **Map context.** Search the vault for the topic, synonyms, projects, and neighboring concepts. Read enough relevant notes to make meaningful links, not keyword matches.
5. **Research and teach.** Answer the user directly, explain findings in small chunks, cite claims, preserve uncertainty, share resources when they improve learning or evidence quality, and correct misunderstandings before moving on.
6. **Check understanding and completeness.** Ask one diagnostic or completeness question per turn. Answer follow-ups with evidence, examples, counterarguments, implementation details, or resources as needed. Capture unresolved gaps in `Questions.md`.
7. **Write incrementally.** For long sessions, update `Conversation.md`, `Questions.md`, `Glossaries.md`, and `Sources.md` as the work progresses. By the end, no research, teaching insight, user question, glossary term, source, or durable knowledge should exist only in chat.
8. **Link into the vault.** Add wikilinks from packet notes to relevant existing notes; suggest backlinks instead of editing unrelated existing notes unless the user asked for full integration.
9. **Report.** Summarize the packet path, files changed, links or backlink suggestions, top takeaways, what the user now understands, and remaining questions.

## Conversation Rules

- Ask only one question per turn; if several details are missing, choose the most blocking one.
- Answer the user's question before asking another.
- If the user is uncertain, offer a small set of options and ask them to choose one.
- Use a teach-back loop for complex topics: plain-language explanation → concrete example → one check question or restatement prompt → correction → continue only when the user is satisfied or uncertainty is captured.
- Ask checks before research, after initial framing, after major findings, and before finalizing notes.
- When the user corrects you, record the correction in `Conversation.md`, update affected packet notes, and prefer the corrected framing unless later evidence contradicts it.
- Record important answers and useful resources in `Conversation.md`; reflect scope-changing details in `Index.md`, `Sources.md`, or `Synthesis.md`.

## Capture Rules

- Put every acronym, abbreviation, domain-specific phrase, specialized term, jargon term, and piece of domain nomenclature in `Glossaries.md`, even when explained elsewhere.
- Keep sources, synthesis, claims, questions, conversation, glossary, and atomic knowledge separate.
- Keep citations close to claims; mark confidence when evidence is incomplete or contested.
- Preserve useful quotes verbatim with attribution.
- Distinguish source claims from interpretation; record failed searches or missing evidence when they affect the conclusion.
- Create atomic notes in the packet folder for durable concepts; link each from `Index.md` and back to its source or synthesis section.

## Linking Rules

Use Obsidian wikilinks: `[[Note Title]]` or `[[path/to/Note|alias]]`. Add links only when they explain context: broader concepts, projects, areas, MOCs, sources, authors, methods, tools, domains, supporting/refining/contradicting claims, or active problems. Do not link on shared words alone.
