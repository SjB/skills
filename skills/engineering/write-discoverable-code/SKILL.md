---
name: write-discoverable-code
description: Name and place code for one-hit plain-text search. Use when writing or renaming functions, types, constants, files, errors, or docs, including routine implementation. Not for style, architecture, or type design.
license: MIT
---

# Write discoverable code

The first lookup is usually a plain-text search, and humans never get hover text. Use a language server when you have one; these rules do not replace it. They make the search hit resolve in one read. No memory between sessions.

## 1. Names are search queries

- **Exported symbols get a domain word and enough extra words to grep uniquely.**
  `diffUserObjects`, not `diff`. `queueEventForDispatch`, not `queue`.
  Measured on a ~700k-line monorepo: 1-word exported names are globally unique 61% of
  the time; 3-word names 96%; 4+ words 98%. Three words is the knee there. In a small
  repo, two unique words is often enough. Use the shortest name that greps uniquely
  in the repo you are editing. Do not pad to three.
- **Give generic verbs their object.** `sanitizeEmailHtml`, not `sanitize`;
  `validateSmtpConfig`, not `validateConfig`. Qualify only as far as uniqueness
  requires, then stop.
- **One definition site per symbol.** Never copy a function between files; move it and
  delete the original in the same change. Shared helpers get one concept-named home
  and are imported everywhere else.
- **Do not rely on the module path to disambiguate a generic name.** The import that
  disambiguates `users/diff.ts` from `orders/diff.ts` sits at the top of the file; the
  search hit is at line 300. Put the context in the symbol (`formatDurationMs`), not the
  folder. Exception: rigid, absolute conventions where the path carries the meaning
  (e.g. every contract file exporting `Input`/`Output`).
- **One concept, one spelling.** Pick `organizationId` or `orgId` and use it everywhere;
  every synonym splits every future search in half. Reuse existing vocabulary in the
  codebase you are editing rather than introducing near-synonyms.
- **When behavior or audience changes, rename in the same commit.** A stale name is
  misinformation with a 100% open rate — that includes visibility markers: a `_private`
  helper that other modules now import needs a public name.
- **Do not rename a name the outside world requires.** Wire-format fields, generated
  code, and framework-required names (`getServerSideProps`, protocol fields, JSON keys
  that must match the wire) stay as they are. A prettier grep is not worth a broken API.
- **Filenames are names too — never use bare-role filenames.** `config.ts`, `types.ts`,
  `utils.ts`, `helpers.ts`, `handlers.ts` say nothing in a search result and collide with
  every other module's config/types/utils in the repo. Prefix the domain:
  `billing-plan-config.ts`, not `config.ts`. (`index.ts` is acceptable only as a
  thin re-export entry point.)

## 2. Type names are search queries too

Compiler errors quote type names back. Name them so that quote is a search hit.
`OrgScopedDb`, not `Ctx2`. Avoid `any`: the compiler goes silent and the agent is back
to guessing.

## 3. Say it where the search lands

- **Doc comment only for what the signature can't show.** Units, timezone, "source time,
  not insert time", ownership. The definition is where a name search lands. Do not
  restate the name: `/** Sanitizes email HTML. */` on `sanitizeEmailHtml` is noise.
- **Plain words only when the identifier will not match the phrase.** Searches arrive
  as natural language ("rate limit", "retry delay"), and camelCase does not match a
  phrase grep — `RateLimiter` is invisible to "rate limit". Put the spaced phrase in
  the doc comment then. If the name already contains those words, don't.
- **A module should make sense with its imports unread.** Each imported name plus its
  doc line should say enough that the reader never has to open the source module. If
  they do, the import's name is failing, not the reader.
- **Keep strings whole.** Never build event names, flags, or error codes with template
  interpolation (`` `github.${entity}.${action}` `` makes `github.pr.merged` unsearchable).
  Write the full literal even when a loop feels DRYer.
- **Error messages start with a unique literal prefix**, so a message seen in a log greps
  straight back to the throw site. ``throw new Error(`Webhook signature mismatch for ${id}`)``,
  never ``throw new Error(`${prefix}: mismatch`)``.
- **One searchable concept per file, and keep orchestrators thin.** The code that answers
  "where is X done?" should live in a module named after X — the thing a reader would
  ask about, not the mechanism inside — not inline in a coordinator,
  pipeline, or service class. An orchestrator should read as a sequence of calls into
  well-named modules; if a reader lands in it from a search, every line should point them
  one hop from the real implementation. Burying the implementation of several concepts in
  one large file makes every search for any of them land on the same wall of code.
  Split until each question-sized concept has one named home, then stop: a helper
  meaningful only inside one concept belongs inline, and a file per tiny function
  fragments one answer across several reads. The test runs both ways: a module that
  answers many unrelated questions is holding more than one concept.
- **Follow the repo's test layout.** Colocate (`foo.test.ts` next to `foo.ts`) only when
  the repo has no convention yet, so one search finds behavior and its specification.
  Do not invent a second layout.
- **Mark dead ends.** `@deprecated` on the old path, with a pointer to the new one.

## Quick checklist before committing

1. Would one search for each new exported name be enough to find its implementation?
2. Is the name the shortest that greps uniquely here, not padded to three words?
3. Is the one thing a caller must know but the signature can't say (units, timezone,
   ownership, ordering) written at the definition, and not a restatement of the name?
4. Do all log/error strings exist verbatim in the source?
5. Did behavior change without a rename — and did wire-format, generated, and
   framework-required names stay put?
6. When code moved, is it gone from where it came from?
7. Do new tests follow the repo's existing test layout?
