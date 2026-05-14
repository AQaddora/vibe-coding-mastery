# execute — scripts

Scripts for this skill will be built in a dedicated session.

Planned helpers:

- `new_run.py` — generates a runfile with a unique ID and the standard template
- `launch_agent.sh` — wraps the CLI invocation for each supported agent
- `close_run.py` — updates the runfile with output, runs the final Refine pass, surfaces doctrine candidates

For now, runfiles are written manually using the template in `references/run-format.md`.
