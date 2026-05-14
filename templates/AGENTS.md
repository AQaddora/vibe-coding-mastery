# Project Agent Instructions — AGENTS.md

> **For any agentic AI tool reading this:** This file contains the project's
> operating rules. Codex, OpenAI Apps SDK, Gemini CLI, and other agentic tools
> use this file as their primary context loader.

## Operating Protocol — PURE Loop

Every task follows four phases:

### P — Prime
Before acting on any task, ensure you have:
- The user's tech stack and versions
- The relevant code style preferences
- The security/performance constraints
- The audience for the output

If any of these are missing, ask before proceeding.

### U — Understand
- Restate the task in your own words before generating code
- Identify ambiguities and ask for clarification
- Map out the approach you'll take

### R — Refine
After producing initial output:
- Self-review as a senior engineer would
- List potential failure modes
- Propose improvements
- Wait for user approval before regenerating

### E — Execute
- Provide runnable, tested code
- Include any required setup commands
- Flag any external dependencies
- Note any production-readiness gaps

## My Default Stack

[FILL THIS IN — replace with your actual stack]

```
Languages: Python 3.11, TypeScript 5.x
Backend: FastAPI 0.110+, Pydantic v2, asyncpg
Database: PostgreSQL 16
Frontend: React 18, Next.js 14
Testing: pytest, vitest
Linting: ruff, eslint
```

## My Rules

> **This section should mirror ai-doctrine.md. Either paste the contents below
> or symlink this file: `ln -s ~/ai-doctrine.md AGENTS.md`**

<!-- Doctrine rules go here -->

## Agent Behavior Requirements

1. **Verify before invent.** Before suggesting any package, library, function name, or API endpoint, verify it exists. Hallucinating package names is a security risk.

2. **Threat-model auth and data code.** Any code touching authentication, authorization, user data, or external APIs must be reviewed for OWASP Top 10 issues before output.

3. **Bound all inputs.** All user-facing inputs (strings, lists, numbers, URLs) must have explicit bounds. Unbounded inputs are DoS vectors.

4. **Async means async.** If the project is async, all I/O must be async. No mixing sync DB drivers in async handlers.

5. **Tests are not optional.** New endpoints, new functions touching user data, or new external integrations require at least one test.

6. **Migrations are dangerous.** Never run DB migrations against production without explicit confirmation. Always run on staging first.

7. **Secrets stay in env.** No hardcoded API keys, tokens, or credentials. Use environment variables and document required vars in README.

## Tool-Specific Notes

### For Codex (OpenAI):
- This file is loaded as your system context for this repo
- Follow PURE phases sequentially, don't skip Refine

### For OpenAI Apps SDK:
- Treat this as the user's standing instructions for any conversation in this project
- Apply rules even when not explicitly invoked

### For Gemini CLI:
- Use this as your `system_instruction` for any agent runs in this directory

---

*Part of the Vibe Coding Mastery doctrine system. Canonical rules live in `ai-doctrine.md`.*
