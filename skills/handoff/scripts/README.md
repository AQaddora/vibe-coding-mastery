# handoff — scripts

Scripts for this skill will be built in a dedicated session.

Planned helpers:

- `estimate_pressure.py` — heuristic detector that scores current conversation context pressure (turn count, files-read count, scope drift). Returns a recommendation: continue / suggest_handoff / urgent_handoff.
- `build_handoff.py` — given an in-flight conversation state dump, generates a handoff block matching `references/handoff-format.md`.
- `replay_handoff.sh` — paste a handoff block into stdin, get back a list of the doctrine sections it references so you can preload them.

For now, the skill operates by prompting alone — invoking the `prime` skill first, then producing the handoff block manually following the format spec.
