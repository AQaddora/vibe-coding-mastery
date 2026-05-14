# Contributing to Vibe Coding Mastery

Thanks for thinking about contributing. This repo is split into two zones with different contribution rules.

## What's open to contributions

**Skills, templates, and tools** under MIT license. Pull requests welcome for:

- New skills that extend the PURE + AI Doctrine workflow
- Improvements to existing skill scripts (bug fixes, cross-platform support, better error messages)
- New templates for additional AI coding tools (Aider, Cline, Continue, Zed, etc.)
- Tools that automate session production (slide builders, video processors, transcript generators)

## What's closed

**Course content** in `sessions/` and `docs/` is All Rights Reserved. We do not accept content PRs.

If you spot a factual error, typo, or broken link in published content, open an issue with the `content-fix` label — we'll handle the edit ourselves.

## How to propose a new skill

1. Open an issue using the `skill-suggestion` template
2. Describe the trigger phrases, the protocol, and how it integrates with the doctrine
3. Wait for maintainer approval before writing code
4. Build inside `skills/<your-skill-name>/` following the structure of an existing skill
5. Include `SKILL.md`, at least one reference doc, and any scripts your skill needs
6. Submit a PR

## Code style

- Bash: `set -euo pipefail`, `shellcheck`-clean, POSIX where possible
- Python: 3.10+, type hints, no external deps for skill scripts (stdlib only)
- Markdown: one sentence per line in source for clean diffs

## Reviewing

Maintainers review weekly. Tag `@AQaddora` on urgent fixes.
