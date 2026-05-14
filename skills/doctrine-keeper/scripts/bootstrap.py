#!/usr/bin/env python3
"""
bootstrap.py — Create a fresh ai-doctrine.md for a new operator.

Usage:
    python3 bootstrap.py                    # Creates ~/ai-doctrine.md
    python3 bootstrap.py --local            # Creates ./ai-doctrine.md (project-scoped)
    python3 bootstrap.py --path /custom/path/doctrine.md
"""
import argparse
import os
from datetime import date
from pathlib import Path

DOCTRINE_HEADER = """# AI Operating Doctrine

> **Owner:** {owner}
> **Started:** {start_date}
> **Rule count:** 0
> **Last updated:** {start_date}

This is your living rulebook for working with AI tools.
Every entry is a hard-won lesson — not theory, not advice from a YouTube video.
Yours alone. Compounds weekly.

---

## How To Use This File

1. **Add to it after every meaningful AI session.** Use the `doctrine-keeper` skill,
   or append manually following the format in [entry-format.md](#).

2. **Read 5 random entries before starting any new project.** This is how the rules
   stay alive in your working memory.

3. **Sync it everywhere.** Run `sync_to_agents.sh` once per project to symlink
   into CLAUDE.md, AGENTS.md, .cursorrules, and .github/copilot-instructions.md.

4. **Review monthly.** Promote High-severity rules into your default Prime template.
   Retire rules that no longer apply (e.g., model upgrades made them obsolete).

---

## Categories (PURE + T)

- **Prime** — Context-setting rules (most rules go here)
- **Understand** — Verification rituals
- **Refine** — Iteration patterns
- **Execute** — Workflow rules
- **Trap** — Failure modes (war stories)

See [categories.md](#) for the full guide.

---

## My Default Primer

> *This section is your master primer. Every long AI session should start by pasting
> something close to this. Update it as your stack and style evolve.*

```
Stack: [Your stack — e.g., Python 3.11, FastAPI 0.110, Pydantic v2, asyncpg, PostgreSQL 16]
Style: [Your style — e.g., type hints everywhere, no print statements, pytest for tests]
Constraints: [Your constraints — e.g., production code, real user data, sub-100ms latency]
Threat model: [Your threat model — e.g., assume all inputs hostile]
Audience: [Who reads/runs this code]

I will give you tasks one at a time. Confirm context, then wait.
```

---

## Rules

*Entries below. Newest at the bottom. Never delete — only deprecate by adding
a follow-up entry that supersedes.*

---

<!-- BEGIN_ENTRIES -->

<!-- END_ENTRIES -->

---

## Retired Rules

*Rules that no longer apply (model upgrade, tech deprecation, etc.).
Keep here for historical context, don't delete.*

<!-- BEGIN_RETIRED -->

<!-- END_RETIRED -->
"""


def main():
    parser = argparse.ArgumentParser(description="Bootstrap a fresh ai-doctrine.md")
    parser.add_argument("--local", action="store_true",
                        help="Create in current directory instead of home")
    parser.add_argument("--path", type=str,
                        help="Custom path (overrides --local)")
    parser.add_argument("--owner", type=str, default=None,
                        help="Your name (defaults to $USER)")
    parser.add_argument("--force", action="store_true",
                        help="Overwrite if file exists")
    args = parser.parse_args()

    if args.path:
        target = Path(args.path).expanduser().resolve()
    elif args.local:
        target = Path.cwd() / "ai-doctrine.md"
    else:
        target = Path.home() / "ai-doctrine.md"

    if target.exists() and not args.force:
        print(f"⚠️  Doctrine already exists at {target}")
        print(f"   Use --force to overwrite, or pick a different path.")
        return 1

    owner = args.owner or os.environ.get("USER", "Operator")
    content = DOCTRINE_HEADER.format(
        owner=owner,
        start_date=date.today().isoformat()
    )

    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")
    print(f"✅ Created doctrine at {target}")
    print(f"   Owner: {owner}")
    print(f"   Started: {date.today().isoformat()}")
    print()
    print("Next steps:")
    print(f"  1. Fill in your default primer (line ~40 in the file)")
    print(f"  2. Run `sync_to_agents.sh` in any project to symlink this everywhere")
    print(f"  3. Use the doctrine-keeper skill to add your first rule")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
