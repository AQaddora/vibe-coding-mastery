---
name: execute
description: Delegates real work to a coding agent (Claude Code, Cursor agent mode, Codex, Aider) and tracks the run end-to-end. Triggers on "execute", "run agent", "ship this", "delegate this", "hand off to Claude Code". Creates a run reference, watches for completion signals, links output back into the conversation, and offers to save successful execution patterns to ~/ai-doctrine.md so the same delegation playbook works across every agentic tool the user has installed.
license: MIT
---

# Execute

The fourth letter of **PURE**. The phase where Prime, Understand, and Refine pay off.

By the time Execute fires, the AI agent knows the stack (Prime), the goal (Understand), and the quality bar (Refine). All that's left is to *run it and verify*. This skill makes that handoff explicit and trackable.

## When to Use This Skill

Trigger when the user:

- Says "execute", "run agent", "ship this", "delegate this", "hand off"
- Has approved a comprehension brief and a refined plan
- Asks the AI to "go do it" or "run Claude Code on this"
- Wants to chain a multi-step run across files/branches

## How It Works (4-Step Protocol)

### Step 1 — Confirm preconditions

Before starting any agent run, confirm:

- [ ] Primer is loaded (Prime ran or `~/ai-doctrine.md` defaults are active)
- [ ] Comprehension brief is approved (Understand ran and user said yes)
- [ ] Quality bar is set (Refine pass on the *plan*, not just the code)
- [ ] Agent target chosen (Claude Code, Cursor agent, Codex CLI, Aider, Gemini CLI, etc.)
- [ ] Branch / working dir / commit message convention agreed

If anything is missing, route back to the appropriate skill.

### Step 2 — Create the run reference

Generate a short run ID (e.g., `exec-2026-05-13-jwt-auth`) and write a runfile to `./runs/<id>.md` (or `~/.vibe-coding/runs/<id>.md` if no project dir):

```markdown
# Run [id]

- Goal: [from comprehension brief]
- Agent: [claude-code | cursor | codex | aider | gemini-cli | other]
- Started: [ISO datetime]
- Primer source: [~/ai-doctrine.md sections X, Y, Z]
- Refine pattern: [which reviewer roles]
- Acceptance criteria: [checklist]
- Status: in_progress

## Output
[updated when complete]
```

This is how the `organize-agents` skill tracks runs later.

### Step 3 — Launch the agent

Provide the user with the exact invocation:

```bash
# Claude Code
claude "$(cat runs/exec-2026-05-13-jwt-auth.md)"

# Cursor agent
# Open Cursor, paste the runfile as the agent prompt

# Codex CLI
codex run -f runs/exec-2026-05-13-jwt-auth.md

# Aider
aider --message "$(cat runs/exec-2026-05-13-jwt-auth.md)"
```

The user runs it. The skill waits or polls (manual for now — scripts pending).

### Step 4 — Verify and close

When the agent reports done:

1. Read the diff/output
2. Re-run the Refine reviewer role one last time on the actual code
3. Update the runfile: status: completed, output summary, lessons
4. Offer to save the run pattern to `~/ai-doctrine.md` as an **Execute**-category rule

## Files in This Skill

| File | Purpose |
| --- | --- |
| `SKILL.md` | This file |
| `references/run-format.md` | Canonical runfile format — TODO |
| `scripts/README.md` | Scripts placeholder |

## Operational Rules

1. **Never execute without a brief.** If the user skips Understand, push back. Brief takes 2 minutes, executes safely.
2. **One agent, one run.** Don't fan out to three agents on the same task — the merge is worse than the parallel speed.
3. **Capture the invocation verbatim.** The exact CLI command is doctrine gold — save it.
4. **Treat the runfile as the contract.** If the agent's output doesn't satisfy the acceptance criteria, reject — don't accept and refactor.
5. **Close the loop with Refine.** Even after a clean run, do one final reviewer-role pass on the actual code.

## Doctrine Integration

Execute generates two kinds of doctrine entries:

1. **Execute-category rules** — "For multi-file refactors in this codebase, Claude Code agent mode with primer X and reviewer role Y is the fastest path."
2. **Trap entries** — when an agent run fails interestingly, save the failure mode so the next session preempts it.

Save through `doctrine-keeper`. After `sync_to_agents.sh`, the next time the user opens Cursor or Aider for the same task class, the rules are loaded automatically.

## Example Invocation

**User:** "Execute the JWT refactor we just refined."

**Skill activates:**

> Preconditions check:
> ✓ Primer loaded (from ~/ai-doctrine.md Default Primer + Prime #07)
> ✓ Comprehension brief approved 10 min ago
> ✓ Refine pass complete (senior security review, 5 issues addressed)
> ✓ Agent target: Claude Code
> ✓ Branch: feat/jwt-refresh-hardening
>
> Created runfile: `./runs/exec-2026-05-13-jwt-refactor.md`
>
> Invocation:
> ```bash
> claude --workdir . "$(cat runs/exec-2026-05-13-jwt-refactor.md)"
> ```
>
> Run it. I'll wait for the diff, then we'll close with one final Refine pass.

---

*Part of the [Vibe Coding Mastery](https://github.com/AQaddora/vibe-coding-mastery) skill suite. MIT licensed.*
