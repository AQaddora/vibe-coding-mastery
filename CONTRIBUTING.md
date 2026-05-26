# Contributing to Vibe Coding Mastery

Thanks for thinking about contributing. This repo is split into two zones with different contribution rules.

## What's open to contributions

**Templates and tools** under MIT license. Pull requests welcome for:

- New templates for additional AI coding tools (Aider, Cline, Continue, Zed, etc.)
- Tools that automate session production (slide builders, video processors, transcript generators)
- Fixes / improvements to `install.sh` (the shim that delegates to [pure-skill-suite](https://github.com/AQaddora/pure-skill-suite))

## What's closed

**Course content** in `sessions/` and `docs/` is All Rights Reserved. We do not accept content PRs.

If you spot a factual error, typo, or broken link in published content, open an issue with the `content-fix` label — we'll handle the edit ourselves.

## Skill contributions go to a different repo

Skills now live in [**AQaddora/pure-skill-suite**](https://github.com/AQaddora/pure-skill-suite). To propose a new skill or improve an existing one:

1. Open an issue / PR **on pure-skill-suite**, not here
2. Follow the skill structure documented in that repo's README
3. The course's `./install.sh` shim picks up your change automatically once it merges to `pure-skill-suite/main`

Issues opened here for skill bugs will be redirected — saves time to post in the right repo first.

## Code style

- Bash: `set -euo pipefail`, `shellcheck`-clean, POSIX where possible
- Python: 3.10+, type hints, no external deps for skill scripts (stdlib only)
- Markdown: one sentence per line in source for clean diffs

## Reviewing

Maintainers review weekly. Tag `@AQaddora` on urgent fixes.
