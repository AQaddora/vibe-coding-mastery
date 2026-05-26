#!/usr/bin/env bash
# vibe-coding-mastery — entry-point installer.
#
# The PURE Skill Suite has its own repo:
#   https://github.com/AQaddora/pure-skill-suite
#
# This shim clones (or updates) it as a sibling of vibe-coding-mastery and
# delegates to its installer. Keeps the course quick-start a single command.
#
# Override the clone location:
#   SUITE_DIR=/path/to/pure-skill-suite ./install.sh
#
# Pass-through flags work — anything after this script's name is forwarded
# to skills/install.sh in the suite (e.g. ./install.sh --no-project-wiring).

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default: sibling directory next to vibe-coding-mastery. Same parent dir so
# users can find both repos side-by-side. Override with SUITE_DIR env var.
SUITE_DIR="${SUITE_DIR:-$(dirname "$HERE")/pure-skill-suite}"
SUITE_REPO="https://github.com/AQaddora/pure-skill-suite.git"

echo "vibe-coding-mastery installer"
echo "  course repo : $HERE"
echo "  skills repo : $SUITE_DIR"
echo

if [ -d "$SUITE_DIR/.git" ]; then
  echo "→ Updating existing pure-skill-suite clone …"
  git -C "$SUITE_DIR" pull --ff-only origin main
elif [ -d "$SUITE_DIR" ]; then
  echo "ERROR: $SUITE_DIR exists but is not a git repo." >&2
  echo "Remove or rename it, then re-run. Or set SUITE_DIR to a different path." >&2
  exit 1
else
  echo "→ Cloning pure-skill-suite from $SUITE_REPO …"
  git clone --depth=1 "$SUITE_REPO" "$SUITE_DIR"
fi

echo
echo "→ Delegating to skill-suite installer …"
echo
exec "$SUITE_DIR/skills/install.sh" "$@"
