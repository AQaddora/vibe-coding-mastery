# pure-orchestrator — scripts

Scripts for this skill will be built in a dedicated session.

Planned helpers:

- `start_loop.py` — initializes a PURE loop runfile with all five phase slots
- `phase_checkpoint.sh` — gates progression between phases; logs deviations
- `capture_candidates.py` — extracts doctrine candidates from a completed loop runfile

For now, the orchestrator operates by prompting alone — invoking the other skills in sequence.
