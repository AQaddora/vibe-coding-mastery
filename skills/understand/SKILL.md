---
name: understand
description: Clarifies scope before code is written. Summarizes existing context, identifies gaps, and asks targeted clarifying questions one at a time so the AI doesn't sprint in the wrong direction. Triggers on "understand this", "what am I missing", "clarify requirements", "make sure you got it", or any vague feature request. Produces a structured comprehension brief that the user approves before any code is generated, and offers to save useful clarification patterns to ~/ai-doctrine.md so every other AI tool (Cursor, Copilot, Codex, Gemini) starts with the same comprehension habit.
license: MIT
---

# Understand

The second letter of **PURE**. The phase that saves you from shipping the wrong thing fast.

Most AI failures aren't generation failures. They're comprehension failures — the AI built exactly what you asked for, and what you asked for wasn't what you needed. This skill closes that gap before any code is written.

## When to Use This Skill

Trigger when the user:

- Says "understand this", "what am I missing", "clarify this", "make sure you got it"
- Gives a vague feature request ("add user search")
- Hands over a long thread or file and asks "do you have the context?"
- Asks the AI to confirm scope before coding
- Says "ask me what you need" or "what's unclear?"

## How It Works (4-Step Protocol)

### Step 1 — Restate

Restate the task back to the user in your own words, in two layers:

1. **Surface restatement** — what the user literally asked
2. **Inferred intent** — what they probably mean given context (project, doctrine, conversation history)

Surface gaps where surface ≠ inferred.

### Step 2 — Catalogue ambiguities

List every assumption your restatement implicitly makes. Group them by:

- **Blocking** — would change the solution architecture (e.g., "is this a one-time script or production endpoint?")
- **Material** — would change the implementation details (e.g., "do we need pagination?")
- **Minor** — would change naming or comments only

### Step 3 — Ask one question

Present blocking ambiguities first, **one at a time**. Never fire a five-question survey. After the user answers, re-evaluate — sometimes one answer collapses three other questions.

### Step 4 — Produce the comprehension brief

When ambiguities are resolved, output a structured brief:

```markdown
## What I'll Build

**Goal:** [one sentence]
**Inputs:** [what comes in]
**Outputs:** [what goes out]
**Constraints:** [perf, security, compatibility]
**Out of scope:** [what we are NOT doing this round]
**Open questions:** [if any remain that aren't blocking]
```

Wait for the user to approve before handing off to Refine or Execute. Offer to save valuable clarification patterns to `~/ai-doctrine.md`.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/comprehension-brief.md` | Canonical brief template — TODO: annotated examples |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Restate before you ask.** Reading back what you heard catches half the ambiguities for free.
2. **One question at a time.** Five questions = the user picks the easy one and skips the hard one.
3. **Block on blockers.** Don't move to Refine/Execute until blocking ambiguities are resolved.
4. **Surface assumptions explicitly.** "I'm assuming X" is a real statement; "I'll do X" without flagging the assumption is a future bug.
5. **Time-box.** If clarification takes >5 messages, the task is too big — split it.

## Doctrine Integration

This skill captures two kinds of doctrine-worthy patterns:

1. **Clarification prompts that worked** — Save as **Understand**-category rules. ("Always ask 'is this a one-time script or production?' for any data-processing request.")
2. **Common ambiguity classes** — Save as **Understand** rules. ("In this codebase, 'user' is ambiguous — clarify customer vs admin vs internal_user.")

Save flow routes through `doctrine-keeper`. After the next `sync_to_agents.sh`, the same comprehension habit applies in Cursor, Copilot, Codex, Gemini, and Windsurf.

## Example Invocation

**User:** "Add user search to the dashboard."

**Skill activates:**

> Surface: "Add a user-search feature to the dashboard."
> Inferred (from your CLAUDE.md): admin-facing dashboard, server-side search, must filter by tenant.
>
> Before I plan: is this **substring search on name + email**, or **fuzzy search across all profile fields including custom attributes**? The two need very different indexing strategies.

*[User clarifies.]*

> Got it. Here's the brief — approve and I'll move to Refine:
>
> **Goal:** Add a substring search on user.name + user.email filtered by current admin's tenant.
> **Inputs:** Search query string, current admin session
> **Outputs:** Paginated user list (20/page)
> **Constraints:** ≤100ms p95, tenant-scoped, case-insensitive
> **Out of scope:** Fuzzy matching, custom attribute search, audit logging
> **Open questions:** None blocking
>
> 💡 Doctrine candidate: "For any 'add X to dashboard' request, always clarify substring vs fuzzy vs faceted search before planning." Save?

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
