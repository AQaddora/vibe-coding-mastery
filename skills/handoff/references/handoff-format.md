# Handoff Block Format — Reference

The canonical structure of a handoff block. The block must be:

- **Plain Markdown** — works pasted into any AI tool (Claude, Cursor, ChatGPT, Codex, Gemini, Aider, Windsurf)
- **Self-contained** — the new chat does not need access to the old conversation
- **Doctrine-anchored** — references `~/ai-doctrine.md` sections rather than embedding stale doctrine inline
- **One paste, one block** — wrap the entire thing in a single fenced code block so the user copies it in one motion

## Canonical Template

````markdown
# HANDOFF — [Task Title]
## Continuation from a long chat session

**Date:** [YYYY-MM-DD]
**Origin:** [AI tool + rough turn count — e.g., "Claude session, ~52 turns"]
**Status:** [one-line status — e.g., "Plan approved, partial code written, paused at revocation backend decision"]

---

## 🎯 Mission
[One sentence — what success looks like]

## 🔒 Locked decisions (DO NOT re-litigate)
- [Decision 1 — specific, final]
- [Decision 2]
- [Decision 3]
...

## ❓ Open questions (resolve first)
[Listed in priority order. Number them if there are multiple.]
1. [Open question with the choices the user is between]

## ✅ What's done
- [Artifact 1 — file path, commit SHA, link to design, etc.]
- [Artifact 2]
- [Artifact 3]

## ⏭ What's next
[The immediate 1–5 next actions when the new chat picks up]
1. [Action 1]
2. [Action 2]
3. [Action 3]

## 📚 Doctrine pointers
Load these from ~/ai-doctrine.md before working:
- [Section / rule reference 1]
- [Section / rule reference 2]
- [Stack tag or category]

## 📁 Files in scope
- [path/to/file1.py]
- [path/to/file2.ts]

## 📏 Estimated remaining
[Rough time + file count + scope shape — e.g., "~2 hours of work. ~3 files modified. ~1 new file."]

---

## Instructions for the new chat

You are taking over a multi-turn task from a previous AI session.
Trust this handoff — the decisions above are locked.

1. Confirm you've read ~/ai-doctrine.md (run the `prime` skill if available)
2. Resolve the open question(s) with the user
3. Continue from "What's next" step 1

// yalla — let's ship.
````

## Section-by-section guidance

### Mission

One sentence. Imperative. Specific.

✅ "Harden the JWT refresh-token path on /auth/* endpoints. Production code. Must pass senior-security review."
❌ "Improve auth somehow."

### Locked decisions

Choices that are final. The new chat must accept these and move on — re-litigating burns the context you just saved.

✅ "JWT signing: RS256 only, algorithm explicitly pinned"
❌ "We discussed using RS256"

A locked decision should:

- Be specific (algorithm name, library version, file path)
- Not be a discussion ("we're leaning toward X")
- Encode the *why* if it took more than 2 messages to settle on

### Open questions

What's pending the user's input. Include the options if the user is between alternatives.

✅ *"Revocation list storage: Option A — Redis sorted set, TTL = expiry. Option B — Postgres table, indexed on jti."*
❌ *"How should we do revocation?"*

### What's done

Concrete artifacts only. File paths, commit SHAs, links.

✅ "/auth/login refactor — committed: 4ac21b8"
❌ "Made progress on login"

### What's next

Immediate next 1–5 actions. Should be small enough that the new chat can execute the first one within 5 minutes of resuming.

✅ "1. Pick revocation backend. 2. Implement check in token validation middleware. 3. Add integration tests..."
❌ "Continue working on it."

### Doctrine pointers

Reference `~/ai-doctrine.md` sections by name + rule numbers. **Do not paste doctrine inline** — the new chat reads fresh rules (current, not stale).

✅ "Prime rules tagged #auth #jwt"
✅ "Refine rule #08 (senior-security review after JWT code)"
❌ Pasting 200 lines of doctrine into the handoff block

### Files in scope

Project-relative paths. Help the new chat know what to read first.

### Estimated remaining

Rough numbers — not commitments. Helps the user decide whether to handoff to a larger-context model vs. a same-size fresh chat.

## Anti-patterns (don't do this)

❌ **Summarizing the whole conversation.** Burns tokens the new chat doesn't need. Locked decisions + what's done is enough.

❌ **Pasting doctrine inline.** Stale by the time the user reads it. Reference by section name instead.

❌ **Vague status.** "Working on auth stuff" tells the new chat nothing actionable.

❌ **Multiple fenced blocks.** One paste, one block. Nested fences break Markdown rendering in some tools.

❌ **Tool-specific syntax.** No Claude-specific tags, no Cursor-specific commands. Plain Markdown.

❌ **Including AI's own reasoning chain.** The new chat doesn't need to know how we got here. It needs to know where we are.

## Real example

The most rigorous handoff block this repo has ever seen is the original cowork handoff that bootstrapped the whole project — see commit `<initial>`'s description of the technique. Every section above is grounded in patterns that worked there.
