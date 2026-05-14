# Primer Format — Reference

> **Status:** TODO — fill in annotated examples in a future session.

## Canonical Template

```
Stack: [languages + frameworks + versions]
Style: [naming, formatting, testing, linting]
Constraints: [perf, latency, deadlines, compliance]
Audience: [who reads/runs this code]
Threat model: [trust boundaries, hostile inputs, sensitive data]

I will give you tasks one at a time. Confirm context, then wait for the task.
```

## Field Guidance — TODO

- [ ] Stack — minimum required: language version + 1 framework + DB. Optional: 3rd-party libs that matter.
- [ ] Style — what changes how AI writes code, not what changes how it reads.
- [ ] Constraints — quantified where possible (e.g., "p95 < 100ms", not "fast").
- [ ] Audience — affects code review tone and comment density.
- [ ] Threat model — must be explicit for any code touching user data or auth.

## Examples — TODO

- [ ] FastAPI service primer (annotated)
- [ ] Next.js + tRPC primer (annotated)
- [ ] Data-engineering / Airflow primer (annotated)
- [ ] Embedded / Rust primer (annotated)
- [ ] Mobile / React Native primer (annotated)

## Anti-Patterns — TODO

- [ ] Vague stack ("modern Python") → specify versions
- [ ] Listing tools the user *has* but doesn't use ("we have Redis but I'm not using it")
- [ ] Threat models that aren't enforceable ("be secure")
