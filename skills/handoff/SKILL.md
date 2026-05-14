---
name: handoff
description: Migrates an in-flight AI coding session to a fresh chat (or a larger-context model) without losing state. Triggers when the user says "handoff this", "we're running out of context", "fresh chat for this", "this is getting heavy", "prepare a handoff", "context window is getting full" — OR when the AI detects (heuristically) that the remaining work won't fit the current conversation. Always runs AFTER Prime has completed so the new chat boots loaded with the primer. Produces a copy-pasteable Markdown handoff block that works pasted into any AI tool (Claude, Cursor, Copilot, Codex, ChatGPT). Captures repeated handoff patterns into ~/ai-doctrine.md so the user's handoff discipline carries across every tool via sync_to_agents.sh.
license: MIT
---

# Handoff

The context-window evacuation skill.

Every long AI coding session eventually hits one of three walls: the conversation gets too long for the model's remaining window, the task scope expanded mid-session, or the chat got polluted with dead-ends and irrelevant tangents. The fix isn't "keep going and hope" — it's a clean handoff to a fresh chat that starts already loaded.

This skill turns that handoff into a one-block ritual instead of an improvised paste-job.

## When to Use This Skill

### User-triggered

Trigger when the user says any of:

- "handoff this", "prepare a handoff", "hand this off"
- "we're running out of context", "this is getting heavy", "fresh chat for this"
- "context window is getting full", "running long, let's migrate"
- "save state and move to a new session"

### AI-triggered (heuristic detection)

The AI should *proactively suggest* a handoff when it detects context pressure. Honest caveat: Claude does not have direct access to its own remaining token budget — these are heuristic signals:

- The conversation has crossed roughly 40–60 turns and the task isn't complete
- Many files (>10) have been read into context
- The task scope has expanded substantially since the original primer
- The user is reporting that the AI is "forgetting" earlier instructions
- The current response is approaching the model's typical max output length
- Tool/file references in the conversation are starting to be re-fetched repeatedly

When the AI suggests a handoff, it should phrase the offer briefly and explicitly:

> *"This conversation is getting long enough that I might start dropping earlier context. Want me to prepare a handoff block so we can continue cleanly in a fresh chat?"*

Wait for explicit user approval before proceeding. **Never produce a handoff block without confirmation.**

## How It Works (5-Step Protocol)

### Step 1 — Confirm the handoff with the user

If user-triggered: ask "scope to confirm — single feature, broader project, or just the immediate stuck point?"

If AI-triggered: state the reason, get user approval. Stop here if user says no.

### Step 2 — Ensure Prime is complete

A handoff without a loaded primer is just a TODO list — the new chat will start cold. Before producing the handoff block, verify:

- ✅ `~/ai-doctrine.md` exists and has a Default Primer filled in
- ✅ The current conversation has either run the `prime` skill OR the user has confirmed they want the new chat to read the doctrine directly

If Prime hasn't run in this session, invoke the `prime` skill first. The handoff block will then reference *which doctrine sections are load-bearing for this task* rather than re-pasting them inline.

### Step 3 — Extract handoff state

Examine the conversation and produce these sections (format defined in `references/handoff-format.md`):

1. **Mission** — one-sentence goal of the original task
2. **Locked decisions** — choices that are final, don't re-litigate
3. **Open questions** — items still pending the user's input
4. **What's done** — concrete artifacts produced so far (file paths, code, designs)
5. **What's next** — the immediate next 1–3 actions when the new chat resumes
6. **Doctrine pointers** — which `~/ai-doctrine.md` sections/rules are load-bearing
7. **Files in scope** — paths the new chat will need to read
8. **Estimated remaining effort** — rough size of the task that remains

### Step 4 — Render the handoff block

Wrap everything in a single fenced code block (so the user can copy-paste in one motion). The block must be:

- **Plain Markdown** — works in any AI chat (Claude, Cursor, ChatGPT, Codex, Gemini, Aider)
- **Self-contained** — does not require the new chat to read the old conversation
- **Doctrine-anchored** — points at `~/ai-doctrine.md` rather than embedding stale doctrine inline (the new chat reads the current doctrine fresh)
- **Action-oriented** — opens with "You are taking over from a long chat session..." style framing

### Step 5 — Deliver + offer doctrine save

Output the block to the user with one line of context:

> *"Paste this into a fresh chat (or a Claude session with a larger context window) and tell me what you want to ship next."*

Then offer:

> *💡 Doctrine candidate: should I save the handoff trigger you used here as a rule? (e.g., 'After 50+ turns on a refactor, always suggest handoff before continuing.')*

Save flow routes through `doctrine-keeper`. After the next `sync_to_agents.sh`, the same handoff discipline applies in Cursor / Copilot / Codex / Gemini / Windsurf.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/handoff-format.md` | Canonical handoff block template with annotated example |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Never produce a handoff without explicit user approval.** The block is potentially long — surprise outputs waste the very context you're trying to save.
2. **Always run Prime first.** A handoff without a primer reference produces a cold new chat. If primer isn't loaded, invoke `prime` before continuing.
3. **One block, one paste.** Everything the new chat needs goes in a single fenced Markdown block.
4. **Reference doctrine, don't paste it.** Point at `~/ai-doctrine.md` sections by category and rule number. The new chat reads fresh rules.
5. **Lock decisions explicitly.** A handoff that doesn't mark locked decisions invites re-litigation in the new chat — which burns the context you just saved.
6. **Be honest about token estimation.** If the AI can't accurately estimate remaining context, say so. "I think context is getting heavy" beats "you have 12% left."
7. **Cross-tool by default.** The handoff format must work pasted into Cursor / Copilot / ChatGPT — not just Claude. Plain Markdown, no Claude-specific syntax.

## Doctrine Integration

Three save patterns produced by this skill:

1. **Trigger rules** — "When working on multi-file refactors >40 turns, always suggest handoff before continuing." (category: `Execute`)
2. **Format rules** — "In handoff blocks for security work, always include the threat-model section verbatim." (category: `Prime`)
3. **Anti-patterns** — "Don't try to summarize the whole conversation into the handoff — list locked decisions only. Burned 5k tokens on summary that the new chat didn't need." (category: `Trap`)

Save routes through `doctrine-keeper`. After `sync_to_agents.sh`, the same handoff playbook is loaded in every other AI tool.

## Position in the PURE Loop

When the `pure-orchestrator` is running a loop and detects context pressure, it invokes handoff **after Phase 1 (Prime) completes and before Phase 2 (Understand)**. The reasoning:

```
   ┌── Prime: load primer into NEW chat will be possible
   │      because primer state is captured in the handoff
   ▼
[PRESSURE DETECTED — suggest handoff]
   │
   ▼
   Handoff block produced
   │
   ▼
   User pastes into fresh chat
   │
   ▼
   Fresh chat: re-runs Prime (cheap — primer is in handoff), then continues at Understand
```

This is why "handoff after Prime" is doctrine-locked. Skipping Prime makes the new chat start cold.

## Example Invocation

### Scenario A — User-triggered handoff mid-feature

**User:** "This conversation is getting long. Let's prepare a handoff for the auth refactor and continue in a fresh chat."

**Skill activates:**

> Confirming scope: the JWT refresh hardening + revocation list, correct?
>
> ✓ Primer is loaded (from ~/ai-doctrine.md Default Primer + Prime #07, #14)
> ✓ Locked decisions: 5 (no algorithm confusion, refresh token rotation enforced, etc.)
> ✓ Open questions: 1 (revocation backend — Redis vs Postgres table)
>
> Here's your handoff block — paste into a fresh chat:
>
> ```markdown
> # HANDOFF — JWT Auth Refactor
> ## Continuation from a long chat session
>
> **Date:** 2026-05-14
> **Origin:** Claude session, ~52 turns
> **Status:** Plan approved, partial code written, paused at revocation backend decision
>
> ---
>
> ## 🎯 Mission
> Harden the JWT refresh-token path on /auth/* endpoints. Production code. Must pass senior-security review.
>
> ## 🔒 Locked decisions (DO NOT re-litigate)
> - JWT signing: RS256 only, algorithm explicitly pinned in jwt.decode
> - Refresh token rotation on every use (no reuse)
> - Refresh token lifetime: 7 days, access token: 15 min
> - Rate limit: 5 req/min/IP on /auth/refresh, 3/min/IP on /auth/login
> - Timing-safe comparison on password check via secrets.compare_digest
>
> ## ❓ Open question (resolve first)
> Revocation list storage:
>   Option A — Redis sorted set, TTL = refresh token expiry. Fast, separate infra.
>   Option B — Postgres table, indexed on token_jti + expires_at. Existing infra.
>
> ## ✅ What's done
> - /auth/login refactor — committed: 4ac21b8
> - Refresh rotation logic — committed: 8de7f12
> - Tests for happy path — committed: a1b2c33
>
> ## ⏭ What's next
> 1. Pick revocation backend (Option A or B)
> 2. Implement revocation check in token validation middleware
> 3. Add integration tests for revoked-token rejection
> 4. Senior-security Refine pass on the full diff before merge
>
> ## 📚 Doctrine pointers
> Load these from ~/ai-doctrine.md before working:
> - Default Primer (Python/FastAPI section)
> - Prime rules tagged #auth #jwt
> - Refine rule: "After any JWT code, run senior-security review prompt"
>
> ## 📁 Files in scope
> - app/auth/jwt.py
> - app/auth/middleware.py
> - app/auth/routes.py
> - tests/auth/test_jwt.py
>
> ## 📏 Estimated remaining
> ~2 hours of work. ~3 files modified. ~1 new file (revocation.py).
>
> ---
>
> ## Instructions for the new chat
>
> You are taking over a multi-turn refactor from a previous Claude session.
> Trust this handoff — the decisions above are locked.
>
> 1. Confirm you've read ~/ai-doctrine.md (Prime should auto-load it)
> 2. Resolve the open question with the user (Option A vs B)
> 3. Continue from "What's next" step 2
>
> // yalla — let's ship.
> ```
>
> 💡 Doctrine candidate: Save trigger pattern "After 50+ turns on a security refactor, always suggest handoff before continuing"?

### Scenario B — AI-detected pressure mid-conversation

**Claude (mid-session, unprompted):**

> Quick note — this conversation is around 45 turns and we've referenced 12 files. I might start losing earlier context, especially the architectural decisions from turn 8–12. Want me to prepare a handoff block so we can continue in a fresh chat with full state?

**User:** "Yes, do it."

[skill activates — same output flow as Scenario A]

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed. Battle-tested — this skill is the formalization of the technique that bootstrapped the entire repo it lives in.*
