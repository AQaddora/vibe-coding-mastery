# Review Prompts — Reference

> **Status:** TODO — fill in the canonical library of reviewer-role prompts in a future session.

## Library Structure

Each prompt should have:

- **When to use** — output type / context that triggers it
- **The prompt** — verbatim, copy-pasteable
- **What it catches** — the bug class it surfaces
- **Doctrine link** — pointer to the entry that proved it works

## Slot Stubs — TODO

- [ ] Senior security engineer — auth / tokens / sessions
- [ ] Principal data engineer — SQL / migrations / indexes
- [ ] Senior API architect — REST / RPC / contract design
- [ ] Senior SRE — deploy / observability / failure modes
- [ ] Hostile peer reviewer — general code, anti-cleverness check
- [ ] Accessibility auditor — frontend / forms / focus management
- [ ] DoS prevention reviewer — input validation / resource bounds
- [ ] Async correctness reviewer — race conditions / I/O mixing
- [ ] Multi-tenancy auditor — row-level security / tenant isolation
- [ ] Cost optimizer — query patterns / N+1 / cold-start sensitivity

## Reusable Wrapper

```
You are a [ROLE]. Review the code below as if it's about to ship to production.

List every issue under these headings:
1. Security / safety issues
2. Correctness / logic issues
3. Performance issues
4. Maintainability issues
5. Missing tests / coverage gaps
6. Style / naming issues (only if they impact readability)

Be exhaustive. Assume the input is hostile. Then rewrite addressing all issues.
```
