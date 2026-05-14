# PURE Phase Protocol — Reference

> **Status:** TODO — formalize checkpoint contracts and override rules in a future session.

## Phase Contracts

Each phase has an entry contract and an exit contract.

### Prime
- **Entry:** Task title or feature name.
- **Exit:** Approved primer block (copy-pasteable into any AI tool).

### Understand
- **Entry:** Approved primer + task description.
- **Exit:** Approved comprehension brief (goal / inputs / outputs / constraints / out-of-scope / open questions).

### Refine
- **Entry:** Approved brief.
- **Exit:** Approved refined plan with reviewer-role critique applied.

### Execute
- **Entry:** Approved plan + agent target + acceptance criteria.
- **Exit:** Agent run completed, output passes final Refine pass, runfile closed.

### Capture
- **Entry:** Completed runfile.
- **Exit:** Doctrine candidates surfaced, user decisions recorded.

## Override Rules — TODO

- [ ] User can fast-track Understand by accepting all inferred defaults
- [ ] User can skip Refine for trivial tasks (must log deviation)
- [ ] User can chain multiple Execute runs under one PURE loop (each gets its own runfile)
- [ ] Capture always runs, even on aborted loops

## Deviation Logging — TODO

- [ ] Every override is recorded in the final runfile
- [ ] `organize-agents` analytics surfaces deviation patterns monthly
- [ ] High-frequency deviations become doctrine candidates ("skip Refine for typo fixes")

## Cross-Phase Doctrine Mapping — TODO

| Loop phase | Doctrine category | Typical entry |
| --- | --- | --- |
| Prime | Prime | "Always include X in primer for Y stack" |
| Understand | Understand | "Always ask X before planning Y" |
| Refine | Refine | "Always run X reviewer role on Y code" |
| Execute | Execute | "Prefer agent X for task class Y" |
| Capture | (any) | Surfaced candidates from above |
