---
name: prime
description: Builds a tailored primer for an AI coding session — the stack, style, constraints, threat model, and audience that should be loaded BEFORE any real task. Triggers when the user says "prime me", "set up context", "build a primer", "start a new session", "I'm starting a new feature", or begins a fresh conversation without context. Reads the user's ~/ai-doctrine.md (if present) to seed the primer with rules they already established. Always offers to save high-leverage primers back to doctrine so the same setup carries to Cursor, Copilot, Codex, Gemini, and Windsurf via sync_to_agents.sh.
license: MIT
---

# Prime

The first letter of **PURE**. The cheapest leverage in AI-assisted coding.

A weak primer means the next 30 minutes are spent correcting the AI. A strong primer means the next 30 minutes are spent shipping. This skill builds the strong one.

## When to Use This Skill

Trigger when the user:

- Says "prime me", "set up context", "build a primer", "start a new session"
- Opens a new conversation and hasn't given any stack info
- Starts working on a new feature, repo, or task type
- Says "I'm switching projects" or "different context now"
- Asks to "load my doctrine" before a task

## How It Works (4-Step Protocol)

### Step 1 — Read existing context

1. Check `~/ai-doctrine.md` for the user's *Default Primer* section + any **Prime**-category rules.
2. Check `./CLAUDE.md`, `./AGENTS.md`, or `./.cursorrules` in the current project for project-specific primers.
3. If both exist, merge: project-specific overrides personal defaults where they conflict.

### Step 2 — Identify the gap

Ask the user (one question at a time, max 3) only for fields that are missing:

- **Stack** — languages, frameworks, versions
- **Style** — naming conventions, formatting, testing approach
- **Constraints** — performance targets, latency budgets, deadlines
- **Threat model** — production code? hostile inputs? sensitive data?
- **Audience** — who reads/runs the output

### Step 3 — Render the primer

Output the primer as a single fenced block the user can copy into any chat. Format defined in `references/primer-format.md`.

### Step 4 — Offer doctrine save

If the user adjusted defaults during the conversation (e.g., "actually use Pydantic v2 for this one"), end by offering to save the new default to `~/ai-doctrine.md` via `doctrine-keeper`. This carries the change to every other AI tool on the user's machine.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/primer-format.md` | Canonical primer template — TODO: fill in with annotated examples |
| `scripts/README.md` | Scripts placeholder (logic to be built in a dedicated session) |

## Operational Rules

1. **Never assume.** If a field is missing, ask once. If the user says "you decide", pick a sensible default and flag it explicitly so they can override.
2. **One question at a time.** Don't fire a 5-question survey. Walk through fields in priority order.
3. **Cite the doctrine.** When pulling defaults from `~/ai-doctrine.md`, name the rule so the user knows where it came from.
4. **Output is copy-pasteable.** The primer must work pasted into a fresh Claude/Cursor/Copilot chat with zero edits.
5. **Suggest doctrine candidates.** Any primer field that took >1 message to establish should be a save candidate.

## Doctrine Integration

Every primer this skill builds is a doctrine candidate. After rendering the primer, the skill checks:

- Did the user supply a new field value not in their doctrine? → Offer to save as a **Prime** rule.
- Did the user accept a sensible default we suggested? → Offer to save as the new default.
- Did the user reject a default ("nah, use bun not npm here")? → Offer to save as a **Prime** rule for this stack.

Save flow routes through `doctrine-keeper`, which appends to `~/ai-doctrine.md`. After the next `sync_to_agents.sh`, every coding tool the user opens reads the new default.

## Example Invocation

**User:** "Prime me for a FastAPI feature."

**Skill activates and produces:**

```
Stack: Python 3.11, FastAPI 0.110, Pydantic v2, asyncpg, PostgreSQL 16
Style: type hints everywhere, pytest, ruff, async/await for all I/O
Constraints: production code, sub-100ms p95 latency, all inputs assumed hostile
Audience: senior backend engineers (review-ready code)
Threat model: public endpoint, rate limiting required, OWASP Top 10 considered

I will give you tasks one at a time. Confirm context, then wait for the task.
```

> *Pulled from `~/ai-doctrine.md` — Default Primer (5 rules) + Prime-category rules #03, #07, #14.*

> 💡 Save adjustment? You overrode "FastAPI 0.108" → "FastAPI 0.110" today. Save as the new default in your doctrine?

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
