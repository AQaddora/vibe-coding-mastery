# refine — scripts

Scripts for this skill will be built in a dedicated session.

Planned helpers:

- `pick_reviewer.py` — classifies the input code and suggests the most useful reviewer role
- `diff_v1_v2.py` — produces a side-by-side diff with rationale annotations
- `refine_chain.sh` — runs the review prompt against the configured LLM CLI (claude / cursor / codex)

For now, the skill operates by prompting alone.
