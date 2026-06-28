# PKM Curation Skill Tests

These tests verify the operating rules in `pkm-curation/SKILL.md` are consistent and harness-agnostic.

## Test: Operating rules prioritize curation over reorganization

**Given:** `common/pkm/pkm-curation/SKILL.md`

**When:** The skill's Operating Rules section is read

**Then:** The first rule states "Prefer curation over reorganization."

**And:** The skill does NOT contain the phrase "Prefer reorganization over curation."

**Notes:**
- This ensures the skill purpose ("curate an Obsidian-style vault") aligns with its operating rules.

---

## Test: No harness-specific tool mandates in operating rules

**Given:** `common/pkm/pkm-curation/SKILL.md`

**When:** The skill's Operating Rules section is read

**Then:** The skill does NOT mandate `cat` as a required tool.

**And:** Any file-read requirement uses tool-neutral language like:
- "Read every file completely before moving, renaming, or modifying it."
- Or harness-specific guidance like "Use the `read` tool."

**Notes:**
- Avoids conflicts with different harness tool suites (pi, opencode, codex, etc.)

---

## Test: File-read requirement is clear and checkable

**Given:** `common/pkm/pkm-curation/SKILL.md`

**When:** The skill's Operating Rules section is read

**Then:** There exists a rule that explicitly requires reading files completely before modification.

**And:** The rule is expressed in a way that can be verified programmatically or by inspection.

**Notes:**
- The `read` tool or equivalent full-file read must be the expected behavior.