# Steve Beaulac Skills

A collection of agent skills (slash commands and behaviors) loaded into my agent.

# Structure

Skills are organized into buckets based on where they can be used and their category.

- Use `/common/` for skills that work in all CLI agents.
- Use `/common/misc/` for skills that work in all CLI agents and are in the misc category.
- Use an agent-specific bucket only when a skill is intended for a specific agent.

Skill are organized into categories based on their function. For example, `/common/misc/` is a bucket for miscellaneous skills that work in all CLI agents.

If we have a skill that is only relevant to a specific agent, we can put it in an agent-specific bucket. For example, if we have a skill that is only relevant to the `opencode` agent, we can put it in `/opencod/misc`.


## list of categories
- `engineering/` — daily code work
- `productivity/` — daily non-code workflow tools
- `misc/` — kept around but rarely used
- `personal/` — tied to my own setup, not promoted
- `in-progress/` — drafts not yet ready to ship
- `deprecated/` — no longer used


Each bucket folder has a `README.md` that lists every skill in the bucket with a one-line description, with the skill name linked to its `SKILL.md`. Bucket `README.md`s and the top-level `README.md` group entries into **User-invoked** and **Model-invoked**.

Every `SKILL.md` is either user-invoked (`disable-model-invocation: true`, reachable only by the human) or model-invoked (model- or user-reachable). For the full definitions, description conventions, and why a user-invoked skill can invoke model-invoked skills but never another user-invoked one, see [docs/invocation.md](./docs/invocation.md).
