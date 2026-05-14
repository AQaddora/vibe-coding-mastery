---
name: refine
description: Runs systematic self-review on AI-generated output before it's accepted. Triggers on "refine this", "review as senior", "improve this", "second pass", or after any AI output that needs a quality gate. Applies role-prompts (senior security engineer, principal architect, hostile reviewer) and produces a v1 → v2 diff with explicit reasoning. Captures effective refine prompts to ~/ai-doctrine.md so the same review patterns travel across Claude, Cursor, Copilot, Codex, Gemini, and Windsurf.
license: MIT
---

# Refine

The third letter of **PURE**. The phase that catches what the first draft missed — for free.

First-draft AI output is rarely production-grade. A second pass with the right framing catches 70–80% of the issues. This skill is the second pass, formalized.

## When to Use This Skill

Trigger when the user:

- Says "refine this", "review as senior", "improve this", "second pass", "tighten this up"
- Has received an AI output that compiles but feels rough
- Wrote auth, payment, or any security-adjacent code with AI
- Is about to commit AI-generated code and asks "is this good?"
- Has finished an Understand phase and wants to harden before Execute

## How It Works (4-Step Protocol)

### Step 1 — Pick the reviewer role

Match the output to the most useful role-prompt:

| Output type | Default reviewer role |
| --- | --- |
| Auth / crypto / token handling | Senior security engineer |
| Database / SQL / migrations | Principal data engineer |
| API design | Senior API architect |
| Frontend UX | Senior product designer + accessibility auditor |
| Infrastructure / CI / deploy | Senior SRE |
| General code | Hostile peer reviewer |

If the user has Refine-category rules in `~/ai-doctrine.md` that match the context, prefer those role-prompts.

### Step 2 — Run the review

Prompt the model (or yourself) with the chosen role and these standing instructions:

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

### Step 3 — Produce a v1 → v2 diff

Show the user:

- The issues list (numbered)
- The rewritten code (v2)
- A short rationale for each non-obvious change

### Step 4 — Offer doctrine save

If the review caught a class of issue worth remembering, offer to save the *review prompt* (not the specific finding) as a **Refine** rule in `~/ai-doctrine.md`. That way the next time the user (or their other AI tools) hit similar code, the same prompt fires.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/review-prompts.md` | Library of reviewer-role prompts — TODO: expand |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Always state the reviewer role explicitly.** "Review this code" gets a generic pass. "Review this as a senior security engineer evaluating an auth flow" gets a useful pass.
2. **Demand exhaustiveness.** "List everything" beats "list the main issues" — let the user decide what's important.
3. **Show the diff, not just the rewrite.** The learning is in the delta.
4. **One refine pass per round.** Two passes drift. If the v2 still has issues, restart the loop with a fresh primer.
5. **Refuse to refine into v3 without user approval.** Stop after v2 to keep momentum.

## Doctrine Integration

Refine is where the highest-value doctrine entries are born. Save:

- **The review prompts that consistently catch bugs** (e.g., "After any SQL, run: 'rewrite assuming the input is hostile'")
- **The bug classes you keep catching** (save as **Trap** entries — the next session will preempt them)
- **The reviewer roles that work for your stack** (e.g., "for Pydantic models, the reviewer role 'senior security engineer for DoS prevention' is uniquely effective")

Save routes through `doctrine-keeper`. After `sync_to_agents.sh`, the same review patterns are loaded in Cursor and Copilot too.

## Example Invocation

**User:** "Refine this JWT login function as a senior security engineer."

**Skill activates and produces:**

> **Review by:** Senior security engineer (auth/token focus)
>
> **Issues found:**
> 1. Token expiry not validated on refresh path — refresh tokens can outlive the access token's intended lifetime.
> 2. Algorithm not pinned — `jwt.decode(..., algorithms=['HS256', 'RS256'])` allows algorithm confusion attacks.
> 3. No rate limiting on `/login` — credential stuffing wide open.
> 4. Timing-safe comparison missing on password check — `==` enables timing oracles.
> 5. No revocation list — logged-out tokens remain valid until natural expiry.
>
> **v2 (rewritten):** *[diff shown]*
>
> 💡 Doctrine candidate: "After any JWT/auth code, always run senior-security review prompt with focus on: expiry validation, algorithm pinning, rate limiting, timing-safe compare, revocation." Save as Refine rule?

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
