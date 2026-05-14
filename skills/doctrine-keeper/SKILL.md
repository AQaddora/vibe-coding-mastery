---
name: doctrine-keeper
description: Captures insights, rules, and learnings from any AI coding conversation into the user's personal ai-doctrine.md file — a single source of truth that is then auto-synced into Claude Code, Cursor, Copilot, Codex, Gemini CLI, and Windsurf so every tool the user opens reads the same hard-won rules. Use this skill whenever the user says "add to doctrine", "save this rule", "capture this learning", "this should be a rule", "doctrine this", "remember this", or asks to record an insight from a prompt/response. Also triggers when the user shares a hard-won learning, a prompt pattern that worked unusually well, a failure mode to avoid, or any rule they want to remember across tools.
license: MIT
---

# Doctrine Keeper

The **memory bus** of the Vibe Coding Mastery skill suite.

Captures hard-won insights from any AI coding session into the user's personal `ai-doctrine.md` — a single file on their machine that is then symlinked into every AI coding tool's config so the same rules travel with the user no matter which tool they open next.

## Why This Skill Exists

Most developers' AI rules live in chat history. They get rediscovered, re-learned, and re-forgotten weekly.

This skill makes those rules *permanent and portable*:

- **Permanent** — every rule is timestamped, categorized, and never overwritten.
- **Portable** — one file, symlinked into Claude Code, Cursor, Copilot, Codex, Gemini CLI, and Windsurf via `scripts/sync_to_agents.sh`. Switch tools, keep memory.

It's the foundation under the PURE Loop (Prime → Understand → Refine → Execute). Every other skill in this suite writes to it.

## When to Use This Skill

Trigger automatically when the user:

- Says any variant of: "add to doctrine", "doctrine this", "save this rule", "capture this learning", "add this to my AI doctrine", "remember this for next time"
- Shares a prompt pattern that worked unusually well
- Discovers a failure mode worth avoiding
- Asks you to "record", "log", or "save" an insight
- Reflects on what they learned from the current conversation
- Completes a PURE Loop run and the orchestrator hands off for capture

## How It Works (4-Step Protocol)

### Step 1 — Locate the Doctrine File

1. Check `~/ai-doctrine.md` (the user's master doctrine).
2. If missing, check `./ai-doctrine.md` (project-scoped).
3. If neither exists, offer to bootstrap one using `scripts/bootstrap.py`.

### Step 2 — Extract Context From the Conversation

Examine the last 5–10 turns. Identify:

- **The trigger prompt** — what the user asked
- **The AI response** — what the AI did well or poorly
- **The hard-won learning** — the rule, pattern, or warning worth preserving
- **The category** — Prime / Understand / Refine / Execute / Trap (see `references/categories.md`)

### Step 3 — Format the Entry

Use the format in `references/entry-format.md`. Required fields:

```markdown
## [YYYY-MM-DD] — [Short Title]

**Category:** [Prime | Understand | Refine | Execute | Trap]
**Stack:** [tech mentioned]
**Severity:** [Low | Medium | High | Critical]

### The Rule
[One sentence. Specific. Reusable.]

### Why It Matters
### Triggering Prompt
### What Went Wrong / Right
### How To Apply Next Time
```

### Step 4 — Append, Update, Confirm

1. Call `scripts/append_entry.py` with the structured fields — it appends safely, increments the rule counter, and updates `Last updated`.
2. Confirm to the user with rule title, category, severity, and total rule count.
3. If this is the user's first entry, suggest they run `scripts/sync_to_agents.sh` once per project to wire the doctrine into every other AI tool.

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file — the instruction set |
| `references/entry-format.md` | Canonical entry format with annotated examples |
| `references/categories.md` | PURE + Trap taxonomy explained |
| `scripts/bootstrap.py` | Creates a fresh `~/ai-doctrine.md` with the standard header |
| `scripts/append_entry.py` | Appends a new entry safely, increments counters |
| `scripts/sync_to_agents.sh` | Symlinks the doctrine into Claude / Cursor / Copilot / Codex / Gemini / Windsurf configs |

## Operational Rules

1. **Never overwrite existing entries.** Always append. Entries are dated and immutable.
2. **One rule per entry.** If the user shares 3 lessons, create 3 entries.
3. **Be specific.** Reject vague rules like "use AI carefully." Push for "when X, always Y, because Z."
4. **Preserve the user's voice.** Don't paraphrase their insight into corporate-speak.
5. **Tag for retrieval.** Categories and stack tags exist so future searches like "show me all FastAPI Refine rules" work.
6. **Confirm before write.** Show the user the rendered entry, get a yes, then append.

## Cross-Tool Memory Architecture

This skill is the **write head**. The other six skills (prime, understand, refine, execute, organize-agents, pure-orchestrator) all route their save requests through `append_entry.py`. The result is a single linear stream of rules that any AI tool can read.

```
        ┌─────────────────────────────────────┐
        │   Any AI coding session (Claude,    │
        │   Cursor, Copilot, Codex, Gemini)   │
        └────────────────┬────────────────────┘
                         │
                "save this rule"
                         │
                         ▼
              ┌──────────────────────┐
              │   doctrine-keeper    │  ← this skill
              │   (write head)       │
              └──────────┬───────────┘
                         │ append_entry.py
                         ▼
                  ~/ai-doctrine.md   ← single source of truth
                         │
                         │ sync_to_agents.sh (symlinks)
            ┌────────────┼────────────┐
            ▼            ▼            ▼
       CLAUDE.md   .cursorrules  .github/copilot-instructions.md
       AGENTS.md   .windsurfrules
       (Codex /                 (and every other tool's
        Gemini)                  config file location)
```

After capturing a rule, every AI tool the user opens in that project reads the same updated doctrine. No re-explaining, no rule drift.

## Doctrine Integration

This *is* the doctrine integration skill. Other skills delegate to it.

## Example Invocation

**User:** "Wallah, that priming trick of telling Claude my Pydantic version saved me 20 minutes. Add to doctrine."

**Skill activates and produces:**

```markdown
## 2026-05-13 — Always state Pydantic major version in primer

**Category:** Prime
**Stack:** Python, Pydantic v2
**Severity:** Medium

### The Rule
When asking AI to write Pydantic models, always state the Pydantic major version (v1 vs v2) in the primer.

### Why It Matters
Pydantic v1 and v2 have incompatible APIs. Without version, AI defaults to v1 syntax half the time, costing 15–20 minutes of debugging.

### Triggering Prompt
> "I'm using Pydantic v2 — write me a model for user profile..."

### What Went Right
Stating the version up-front meant zero rewrites. Code worked first try.

### How To Apply Next Time
Add to default primer template:
`Stack: Python 3.11, Pydantic v2 (use field_validator not validator), FastAPI 0.110+`
```

Confirm to user: *"Logged rule #24 — 'Always state Pydantic major version in primer' under Prime, Medium severity. Total rules: 24. Run sync_to_agents.sh once per project so Cursor and Copilot pick it up too."*

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
