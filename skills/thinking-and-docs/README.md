# Thinking And Docs Skills

Clarify decisions, capture ideas, and improve project documentation.

## User-invoked

- [before-building](before-building/SKILL.md) — Fire the moment the user proposes a build. Instantly surface the 1-3 consequential choices hidden in his idea. Can also be invoked with /before-building.
- [decisions](decisions/SKILL.md) — Ask the agent to list all choices it made during the current work that it is not confident of. Manual-only; invoke with /decisions.
- [level-up](level-up/SKILL.md) — Gauge the user''s technical + product knowledge through 7 adaptive questions, log verbatim answers with honest ratings, and grow a learning plan from the gaps found. Use when the user says "level up", "level-up session", "quiz me", "gauge my knowledge", or wants a new assessment round. Differentiator: this finds and maps gaps; the `teach` skill delivers lessons on them.
- [read-all-adrs](read-all-adrs/SKILL.md) — Read every ADR markdown file in the project's docs/adr/ folder so you have full context on past decisions. Use only when the user explicitly calls it.
- [remind](remind/SKILL.md) — Rewrite the last response simpler and shorter in plain English, prefixed with a 3-5 sentence TLDR of the conversation so far. Manual-only, invoked as /remind.
- [short](short/SKILL.md) — Manually-invoked skill that forces the agent to compress its current answer — strip filler, simplify wording, and cut length while keeping the substance. Use when the user says "short", "shorter", "simpler", "too long", "tl;dr", or wants a more concise version of the previous response.
- [teach](teach/SKILL.md) — Teach the user a new skill or concept, within this workspace.

## Model-invoked

- [brain-to-docs](brain-to-docs/SKILL.md) — Use when the user wants to extract project vision, decisions, and preferences from his head into clear documentation (README + ADRs) through a back-and-forth Q&A loop. Triggers on "brain-to-docs", "build out the docs", "extract the vision", "let's document this project".
- [next-decision](next-decision/SKILL.md) — Drill open decisions one at a time — present the most important decision not yet clarified, give the top four choices, state a preference, ask the user. Use when the user says "next decision", "one decision at a time", or a plan has several unresolved choices. Differentiator: forward-looking; the decisions skill is retrospective (choices already made). Can be invoked with /next-decision.
- [prompt-me](prompt-me/SKILL.md) — Prompt the user with pointed questions to extract what is in his head about a project — remaining work, what is being avoided, what really matters, what does not. Use when the user says "prompt me", "ask me questions", or wants the agent to figure out priorities by questioning him.
- [save-idea](save-idea/SKILL.md) — Quickly capture a content idea into ~/code/content from any repo or chat. Video ideas go to VIDEO-IDEAS.md; smaller podcast topics, guest ideas, questions, and AI observations go to TOPICS.md. Every entry gets a source line referencing the chat and repo it came from. Use when the user says "/save-idea", "save this idea", "video idea", "add a topic", "write this down for a video/podcast". Differentiator: appends to the user''s content backlog — not a reminder, task, or general note tool.
