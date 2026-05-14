#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# new-session.sh — Scaffold a new pre-course session
# ─────────────────────────────────────────────────────────────────────────────
# Usage:
#   ./tools/new-session.sh <number> <slug> "<full title>"
#
# Example:
#   ./tools/new-session.sh 02 defense "Get the Best From AI Tools (Without Getting Burned)"
#
# What it does:
#   - Creates sessions/session-NN-slug/ in the public repo with public/ and private/ subdirs
#   - Drops a README.md in the session root, the public/ subdir, and the private/ subdir
#   - Touches placeholder files so the structure is visible in git
#   - Re-running is safe — won't overwrite existing files
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <number> <slug> \"<full title>\""
    echo "Example: $0 02 defense \"Get the Best From AI Tools (Without Getting Burned)\""
    exit 1
fi

NUM="$1"
SLUG="$2"
TITLE="$3"

# Pad number to 2 digits
NUM=$(printf "%02d" "$((10#$NUM))")

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SESSION_DIR="$REPO_ROOT/sessions/session-$NUM-$SLUG"
PUBLIC_DIR="$SESSION_DIR/public"
PRIVATE_DIR="$SESSION_DIR/private"

echo "📦 Scaffolding Session $NUM — $TITLE"
echo "   Target: $SESSION_DIR"
echo ""

# Create dirs
mkdir -p "$PUBLIC_DIR" "$PRIVATE_DIR"

# ── Session README ───────────────────────────────────────────────────────
README="$SESSION_DIR/README.md"
if [[ ! -f "$README" ]]; then
    cat > "$README" <<EOF
# Session $NUM — $TITLE

**Status:** ⏳ In production
**Runtime:** 30 minutes (target)
**Cost:** Paid (part of the pre-course bundle)

## The promise

*[Fill in the one-sentence promise — what does the trainee walk away able to do?]*

## The trap discussed

*[What goes wrong when developers attempt this without the system from this session?]*

## What you walk away with

- *[Concrete artifact 1]*
- *[Concrete artifact 2]*
- *[Concrete artifact 3]*

## Production notes

Slides, script, practical, assignment, references, and terminology will land in \`public/\` when production completes.

---

[← All sessions](../README.md)
EOF
    echo "  ✓ Created $README"
else
    echo "  · Skipped $README (exists)"
fi

# ── Public placeholders ──────────────────────────────────────────────────
for f in practical.md assignment.md references.md terminology.md; do
    target="$PUBLIC_DIR/$f"
    if [[ ! -f "$target" ]]; then
        echo "# $f — TODO" > "$target"
        echo "  ✓ Created $target"
    else
        echo "  · Skipped $target (exists)"
    fi
done

# ── Private gitkeep ──────────────────────────────────────────────────────
touch "$PRIVATE_DIR/.gitkeep"

# ── Private README in public repo (explains why private/ is empty here) ──
PRIV_README="$PRIVATE_DIR/README.md"
if [[ ! -f "$PRIV_README" ]]; then
    cat > "$PRIV_README" <<EOF
# Private — Session $NUM Production Materials

Production-side files for this session live in the separate private repo:

> **github.com/AQaddora/vibe-coding-mastery-private**

This folder in the public repo stays empty by design. The \`.gitignore\` excludes
the production-side files (scripts, teleprompter, role notes) from this repo.
EOF
    echo "  ✓ Created $PRIV_README"
fi

echo ""
echo "✅ Done. Next steps:"
echo "   1. Fill in $README (the session promise)"
echo "   2. Drop slides.pptx into $PUBLIC_DIR/"
echo "   3. Write production materials in the private repo at sessions/session-$NUM-$SLUG/"
echo "   4. Generate slides.pdf with libreoffice/keynote when slides are final"
