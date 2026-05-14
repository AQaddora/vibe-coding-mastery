#!/usr/bin/env python3
"""
append_entry.py — Safely append a new entry to ai-doctrine.md

Usage:
    Called by the doctrine-keeper skill after extracting context.
    Can also be called manually:

    python3 append_entry.py \\
        --title "Always state Pydantic version" \\
        --category Prime \\
        --severity Medium \\
        --stack "Python, Pydantic v2" \\
        --rule "When asking AI for Pydantic models, always state the major version." \\
        --why "Pydantic v1 and v2 have incompatible APIs." \\
        --prompt "Write me a Pydantic model for user profile" \\
        --outcome "Stating v2 up-front meant zero rewrites." \\
        --apply "Add to default primer: 'Pydantic v2, use field_validator not validator'"
"""
import argparse
import re
import sys
from datetime import date
from pathlib import Path


VALID_CATEGORIES = ["Prime", "Understand", "Refine", "Execute", "Trap"]
VALID_SEVERITIES = ["Low", "Medium", "High", "Critical"]


def find_doctrine() -> Path | None:
    """Find the doctrine file. Project-local takes priority over home."""
    local = Path.cwd() / "ai-doctrine.md"
    if local.exists():
        return local
    home = Path.home() / "ai-doctrine.md"
    if home.exists():
        return home
    return None


def format_entry(args) -> str:
    today = date.today().isoformat()
    tags_line = f"\n**Tags:** {args.tags}" if args.tags else ""

    return f"""## {today} — {args.title}

**Category:** {args.category}
**Stack:** {args.stack}
**Severity:** {args.severity}{tags_line}

### The Rule
{args.rule}

### Why It Matters
{args.why}

### Triggering Prompt
> {args.prompt}

### What Went Wrong / Right
{args.outcome}

### How To Apply Next Time
{args.apply}

---
"""


def update_rule_count(content: str) -> tuple[str, int]:
    """Increment the rule count in the header and return new count."""
    match = re.search(r"> \*\*Rule count:\*\* (\d+)", content)
    if not match:
        return content, -1
    old_count = int(match.group(1))
    new_count = old_count + 1
    content = re.sub(
        r"> \*\*Rule count:\*\* \d+",
        f"> **Rule count:** {new_count}",
        content,
        count=1
    )
    # Also update Last updated
    content = re.sub(
        r"> \*\*Last updated:\*\* [\d-]+",
        f"> **Last updated:** {date.today().isoformat()}",
        content,
        count=1
    )
    return content, new_count


def append_entry(doctrine_path: Path, entry_text: str) -> int:
    """Insert entry before END_ENTRIES marker. Return new rule count."""
    content = doctrine_path.read_text(encoding="utf-8")

    marker = "<!-- END_ENTRIES -->"
    if marker not in content:
        print(f"❌ Doctrine file is malformed — missing {marker}", file=sys.stderr)
        sys.exit(1)

    content = content.replace(marker, entry_text + "\n" + marker)
    content, new_count = update_rule_count(content)

    doctrine_path.write_text(content, encoding="utf-8")
    return new_count


def main():
    parser = argparse.ArgumentParser(description="Append a doctrine entry")
    parser.add_argument("--title", required=True, help="Short title (4-8 words)")
    parser.add_argument("--category", required=True, choices=VALID_CATEGORIES)
    parser.add_argument("--severity", required=True, choices=VALID_SEVERITIES)
    parser.add_argument("--stack", required=True, help="Comma-separated tech")
    parser.add_argument("--rule", required=True, help="The rule, one sentence imperative")
    parser.add_argument("--why", required=True, help="Why it matters, 1-2 sentences")
    parser.add_argument("--prompt", required=True, help="Triggering prompt verbatim/summary")
    parser.add_argument("--outcome", required=True, help="What went wrong or right")
    parser.add_argument("--apply", required=True, help="How to apply next time")
    parser.add_argument("--tags", default="", help="Optional #freeform #tags")
    parser.add_argument("--path", help="Custom doctrine path")
    args = parser.parse_args()

    if args.path:
        doctrine = Path(args.path).expanduser().resolve()
    else:
        doctrine = find_doctrine()

    if not doctrine or not doctrine.exists():
        print("❌ No ai-doctrine.md found.", file=sys.stderr)
        print("   Run bootstrap.py first.", file=sys.stderr)
        sys.exit(1)

    entry = format_entry(args)
    new_count = append_entry(doctrine, entry)

    print(f"✅ Rule #{new_count} added: '{args.title}'")
    print(f"   Category: {args.category}  ·  Severity: {args.severity}")
    print(f"   File: {doctrine}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
