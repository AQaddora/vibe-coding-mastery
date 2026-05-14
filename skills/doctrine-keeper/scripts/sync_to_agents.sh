#!/usr/bin/env bash
# sync_to_agents.sh — Link your ai-doctrine.md into all AI tool configs
#
# Run this ONCE per project. Creates symlinks so every AI tool reads
# the same doctrine. One source of truth.
#
# Usage:
#   ./sync_to_agents.sh              # Use ~/ai-doctrine.md as source
#   ./sync_to_agents.sh /path/to/doctrine.md
#
# Creates (or updates) symlinks at:
#   ./CLAUDE.md                            -> Claude Code
#   ./AGENTS.md                            -> Codex, OpenAI Apps SDK, Gemini CLI
#   ./.cursorrules                         -> Cursor (legacy)
#   ./.cursor/rules/doctrine.mdc           -> Cursor (modern)
#   ./.github/copilot-instructions.md      -> GitHub Copilot
#   ./.windsurfrules                       -> Windsurf

set -euo pipefail

# ───────────────────────────────────────────────────────────────────────────
# Resolve source doctrine
# ───────────────────────────────────────────────────────────────────────────
SOURCE="${1:-$HOME/ai-doctrine.md}"

if [[ ! -f "$SOURCE" ]]; then
    echo "❌ Doctrine not found at: $SOURCE"
    echo "   Run bootstrap.py first:"
    echo "   python3 $(dirname "$0")/bootstrap.py"
    exit 1
fi

# Absolute path for clean symlinks
SOURCE="$(cd "$(dirname "$SOURCE")" && pwd)/$(basename "$SOURCE")"
PROJECT="$(pwd)"

echo "📍 Source doctrine:  $SOURCE"
echo "📍 Linking into:     $PROJECT"
echo ""

# ───────────────────────────────────────────────────────────────────────────
# Helper — create or update a symlink
# ───────────────────────────────────────────────────────────────────────────
link_doctrine() {
    local target="$1"
    local label="$2"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        # Already a symlink — update it
        rm "$target"
        ln -s "$SOURCE" "$target"
        echo "  🔄 Updated  $label  ($target)"
    elif [[ -f "$target" ]]; then
        # Existing file — back it up
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$target" "$backup"
        ln -s "$SOURCE" "$target"
        echo "  ⚠️  Replaced $label  (backup: $backup)"
    else
        # New link
        ln -s "$SOURCE" "$target"
        echo "  ✅ Linked   $label  ($target)"
    fi
}

# ───────────────────────────────────────────────────────────────────────────
# Link into all known AI tool configs
# ───────────────────────────────────────────────────────────────────────────
echo "Linking doctrine into project AI configs:"
echo ""

link_doctrine "$PROJECT/CLAUDE.md"                              "Claude Code"
link_doctrine "$PROJECT/AGENTS.md"                              "Codex / OpenAI Apps / Gemini CLI"
link_doctrine "$PROJECT/.cursorrules"                           "Cursor (legacy)"
link_doctrine "$PROJECT/.cursor/rules/doctrine.mdc"             "Cursor (modern)"
link_doctrine "$PROJECT/.github/copilot-instructions.md"        "GitHub Copilot"
link_doctrine "$PROJECT/.windsurfrules"                         "Windsurf"

echo ""
echo "✅ Done. Every AI tool in this project now reads your doctrine."
echo ""

# ───────────────────────────────────────────────────────────────────────────
# Optional — add to .gitignore so symlinks don't get committed by accident
# ───────────────────────────────────────────────────────────────────────────
GITIGNORE="$PROJECT/.gitignore"
if [[ -f "$GITIGNORE" ]]; then
    if ! grep -q "# AI doctrine symlinks" "$GITIGNORE" 2>/dev/null; then
        echo "💡 Tip: Add these to your .gitignore if you don't want to share your doctrine:"
        echo ""
        cat <<EOF

# AI doctrine symlinks (managed by sync_to_agents.sh)
CLAUDE.md
AGENTS.md
.cursorrules
.cursor/rules/doctrine.mdc
.github/copilot-instructions.md
.windsurfrules
EOF
        echo ""
        echo "   OR keep them committed if your team shares one doctrine."
    fi
fi

echo "🎯 Next: open Claude Code / Cursor / Copilot here — they'll auto-load your doctrine."
