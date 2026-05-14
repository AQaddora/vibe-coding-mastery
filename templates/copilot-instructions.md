# GitHub Copilot — Project Instructions

This file is read automatically by GitHub Copilot for any code generated in this repository.

## Project Context

[FILL IN — short paragraph describing the project, who uses it, the stack]

## Code Style

- Strict typing always (no `any` in TS, full type hints in Python)
- Async/await for all I/O — no callbacks, no blocking calls
- Errors as values when possible (no exceptions for control flow)
- Comments only for *why*, not *what* — code should be self-documenting

## Stack

```
Language: [Python 3.11 / TypeScript 5.x]
Backend:  [FastAPI / Express / Next.js API routes]
Database: [PostgreSQL via asyncpg / Prisma]
Frontend: [React 18 + Next.js / Vue]
Testing:  [pytest / vitest / playwright]
```

## My Doctrine

> **Paste your ai-doctrine.md rules here, or symlink:
> `ln -s ~/ai-doctrine.md .github/copilot-instructions.md`**

<!-- Rules here -->

## Hard Rules

1. **Never suggest packages without verification.** If suggesting any import, the package must demonstrably exist and have a stable release.

2. **Never suggest disabled lint rules.** If linter complains, fix the code, don't disable the rule.

3. **Never write commented-out code.** Delete it. Git has the history.

4. **Never generate auth/crypto from memory.** Use established libraries (bcrypt, argon2, jose, etc.).

5. **Never use synchronous file I/O in async contexts.** Use `aiofiles` / `node:fs/promises`.

6. **Always type external API responses.** Use Pydantic / Zod schemas at all trust boundaries.

7. **Always parameterize queries.** No `f"SELECT * FROM users WHERE id = {user_id}"`.

## When in Doubt

Ask for clarification rather than guess. A 1-message back-and-forth beats 30 minutes debugging hallucinated code.

---

*Part of the Vibe Coding Mastery doctrine system.*
