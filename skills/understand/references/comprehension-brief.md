# Comprehension Brief — Reference

> **Status:** TODO — fill in annotated examples in a future session.

## Canonical Template

```markdown
## What I'll Build

**Goal:** [one sentence — what success looks like]
**Inputs:** [data shape, where it comes from, who provides it]
**Outputs:** [data shape, where it goes, who consumes it]
**Constraints:** [performance, security, compatibility, deadline]
**Out of scope:** [explicit list of what we are NOT doing this round]
**Open questions:** [non-blocking but worth noting]
```

## Ambiguity Buckets — TODO

- [ ] Blocking ambiguities — would change solution architecture (1-time script vs prod, sync vs async, single-tenant vs multi-tenant)
- [ ] Material ambiguities — would change implementation (pagination size, error handling depth, retry policy)
- [ ] Minor ambiguities — would change naming/comments only (camelCase vs snake_case, log verbosity)

## Restatement Patterns — TODO

- [ ] Two-layer restatement (surface + inferred intent)
- [ ] Diff-style restatement when modifying existing code ("you want X, currently it does Y, delta is Z")
- [ ] Negative restatement ("you are NOT asking me to also...")

## Examples — TODO

- [ ] Vague request ("add search") → comprehension brief
- [ ] Bug report ("login broken sometimes") → comprehension brief
- [ ] Refactor request ("clean up this file") → comprehension brief
