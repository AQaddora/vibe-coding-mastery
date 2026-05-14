#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# Vibe Coding Mastery — Skills Installer
# ─────────────────────────────────────────────────────────────────────────────
# What this does:
#
#   1. Creates ~/ai-doctrine.md (your master doctrine — the cross-tool memory)
#   2. Installs all 8 PURE + AI Doctrine skills into ~/.claude/skills/
#   3. Makes scripts executable
#   4. Offers to wire the doctrine into your current project (CLAUDE.md,
#      .cursorrules, AGENTS.md, .github/copilot-instructions.md, .windsurfrules)
#      so Cursor / Copilot / Codex / Gemini / Windsurf all read the same memory
#   5. Verifies everything
#
# The 8 skills:
#   doctrine-keeper      → write head (the memory bus)
#   prime                → P of PURE — build a primer from your stack + doctrine
#   understand           → U of PURE — clarify scope before code
#   refine               → R of PURE — senior-reviewer self-review
#   execute              → E of PURE — delegate to an agent, track the run
#   organize-agents      → registry of agent runs across tools
#   pure-orchestrator    → runs the full P→U→R→E loop with checkpoints
#   handoff              → migrates a long session to a fresh chat without losing state
#
# Run from the skills/ folder:
#   ./install.sh                        # default install
#   ./install.sh --no-sync              # skip "wire into project" step
#   ./install.sh --force                # overwrite existing doctrine
#
# Designed and built by Ahmed Qaddoura · aqaddoura.com
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ─── Flags ───────────────────────────────────────────────────────────────────
NO_SYNC=0
FORCE=0
for arg in "$@"; do
    case "$arg" in
        --no-sync) NO_SYNC=1 ;;
        --force)   FORCE=1 ;;
        --help|-h)
            sed -n '2,30p' "$0"
            exit 0
            ;;
    esac
done

# ─── Paths ───────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR"
CLAUDE_SKILLS_HOME="$HOME/.claude/skills"
DOCTRINE_PATH="$HOME/ai-doctrine.md"

# All 8 skills, in install order (doctrine-keeper first — others depend on it)
SKILLS=(
    "doctrine-keeper"
    "prime"
    "understand"
    "refine"
    "execute"
    "organize-agents"
    "pure-orchestrator"
    "handoff"
)

# ─── Colors (terminal-aware) ─────────────────────────────────────────────────
if [[ -t 1 ]]; then
    BOLD=$(tput bold) DIM=$(tput dim) RESET=$(tput sgr0)
    GREEN=$(tput setaf 2) YELLOW=$(tput setaf 3) BLUE=$(tput setaf 4) RED=$(tput setaf 1)
else
    BOLD="" DIM="" RESET="" GREEN="" YELLOW="" BLUE="" RED=""
fi

section() { echo ""; echo "${BOLD}${BLUE}━━━ $* ━━━${RESET}"; }
ok()      { echo "  ${GREEN}✓${RESET} $*"; }
info()    { echo "  ${DIM}·${RESET} $*"; }
warn()    { echo "  ${YELLOW}!${RESET} $*"; }
fail()    { echo "  ${RED}✗${RESET} $*"; }

cat <<BANNER
${BOLD}
╔══════════════════════════════════════════════════════════════════════╗
║          Vibe Coding Mastery — Skills + AI Doctrine Installer        ║
║                                                                      ║
║  PURE Loop + AI Doctrine — a cross-tool memory system for any        ║
║  developer who uses AI coding assistants. Invented by Ahmed Qaddoura ║
║  · aqaddoura.com                                                     ║
╚══════════════════════════════════════════════════════════════════════╝
${RESET}
BANNER

# ─── Step 1: Sanity checks ───────────────────────────────────────────────────
section "1/5 · Sanity checks"

if ! command -v python3 >/dev/null 2>&1; then
    fail "python3 not found — required for bootstrap and append scripts"
    exit 1
fi
ok "python3 present: $(python3 --version)"

for skill in "${SKILLS[@]}"; do
    if [[ ! -f "$SKILLS_DIR/$skill/SKILL.md" ]]; then
        fail "Missing skill: $skill (no SKILL.md in $SKILLS_DIR/$skill)"
        exit 1
    fi
done
ok "All 8 skills present in $SKILLS_DIR"

# ─── Step 2: Bootstrap the doctrine ──────────────────────────────────────────
section "2/5 · Bootstrap your AI Doctrine"

if [[ -f "$DOCTRINE_PATH" && $FORCE -eq 0 ]]; then
    info "Doctrine already exists at $DOCTRINE_PATH — skipping (use --force to overwrite)"
else
    if [[ $FORCE -eq 1 && -f "$DOCTRINE_PATH" ]]; then
        BACKUP="$DOCTRINE_PATH.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$DOCTRINE_PATH" "$BACKUP"
        warn "Existing doctrine backed up to $BACKUP"
    fi
    python3 "$SKILLS_DIR/doctrine-keeper/scripts/bootstrap.py" --force >/dev/null
    ok "Created $DOCTRINE_PATH"
fi

# ─── Step 3: Install all 7 skills ────────────────────────────────────────────
section "3/5 · Install 8 skills into Claude (~/.claude/skills/)"

mkdir -p "$CLAUDE_SKILLS_HOME"

for skill in "${SKILLS[@]}"; do
    SRC="$SKILLS_DIR/$skill"
    DST="$CLAUDE_SKILLS_HOME/$skill"

    # Make scripts executable
    if [[ -d "$SRC/scripts" ]]; then
        chmod +x "$SRC/scripts/"*.py 2>/dev/null || true
        chmod +x "$SRC/scripts/"*.sh 2>/dev/null || true
    fi

    # Remove old install (whether file, dir, or symlink)
    if [[ -L "$DST" || -e "$DST" ]]; then
        rm -rf "$DST"
    fi

    # Symlink so source updates propagate without reinstalling
    ln -s "$SRC" "$DST"
    ok "linked  $skill  →  $DST"
done

# ─── Step 4: Wire doctrine into current project (optional) ───────────────────
section "4/5 · Wire doctrine into a project (memory bus)"

if [[ $NO_SYNC -eq 1 ]]; then
    info "Skipped — re-run without --no-sync, or run sync_to_agents.sh manually"
else
    echo ""
    echo "  This step symlinks your ~/ai-doctrine.md into every AI tool's config"
    echo "  for the current project (or another path), so Cursor, Copilot, Codex,"
    echo "  Gemini CLI, and Windsurf all read the same memory."
    echo ""
    read -rp "  Wire doctrine into a project now? [Y/n/path] " ANSWER
    ANSWER="${ANSWER:-Y}"

    case "$ANSWER" in
        n|N|no|No|NO)
            info "Skipped — you can run this later from any project:"
            info "  $SKILLS_DIR/doctrine-keeper/scripts/sync_to_agents.sh"
            ;;
        y|Y|yes|Yes|YES)
            TARGET="$PWD"
            echo ""
            ( cd "$TARGET" && "$SKILLS_DIR/doctrine-keeper/scripts/sync_to_agents.sh" ) \
                || warn "sync_to_agents.sh exited with errors (see above)"
            ;;
        *)
            TARGET="$ANSWER"
            if [[ ! -d "$TARGET" ]]; then
                warn "Path '$TARGET' is not a directory — skipping"
            else
                echo ""
                ( cd "$TARGET" && "$SKILLS_DIR/doctrine-keeper/scripts/sync_to_agents.sh" ) \
                    || warn "sync_to_agents.sh exited with errors (see above)"
            fi
            ;;
    esac
fi

# ─── Step 5: Verify ──────────────────────────────────────────────────────────
section "5/5 · Verify installation"

[[ -f "$DOCTRINE_PATH" ]] && ok "Doctrine present:     $DOCTRINE_PATH" || fail "Doctrine missing"

for skill in "${SKILLS[@]}"; do
    DST="$CLAUDE_SKILLS_HOME/$skill"
    if [[ -L "$DST" && -f "$DST/SKILL.md" ]]; then
        ok "Skill installed:      $skill"
    else
        fail "Skill broken:         $skill"
    fi
done

# ─── Done ────────────────────────────────────────────────────────────────────
cat <<DONE

${BOLD}${GREEN}━━━ Installation complete ━━━${RESET}

${BOLD}What you have now:${RESET}
  • A personal AI Doctrine at:  ${BLUE}$DOCTRINE_PATH${RESET}
  • All 8 skills installed in:  ${BLUE}$CLAUDE_SKILLS_HOME${RESET}
  • A memory bus that travels with you across every AI coding tool

${BOLD}The PURE Loop (your new operating system):${RESET}
  ${DIM}P${RESET}  prime              build a primer from your stack + doctrine
  ${DIM}U${RESET}  understand         clarify scope before code
  ${DIM}R${RESET}  refine             senior-reviewer self-review
  ${DIM}E${RESET}  execute            delegate to an agent and track the run
  ${DIM} ${RESET}  organize-agents    registry of agent runs across tools
  ${DIM} ${RESET}  pure-orchestrator  runs the full P→U→R→E loop end-to-end
  ${DIM} ${RESET}  doctrine-keeper    writes every learning back to your doctrine
  ${DIM} ${RESET}  handoff            migrates a long session to a fresh chat cleanly

${BOLD}First time? Try this:${RESET}

  1. ${YELLOW}Fill in your default primer${RESET} (one-time, ~3 minutes):
       \$ ${BLUE}open $DOCTRINE_PATH${RESET}
       (find the 'My Default Primer' section, replace placeholders with your stack)

  2. ${YELLOW}Open Claude${RESET} (claude.ai or Claude Code) and try:
       ${BLUE}"prime me for a FastAPI feature"${RESET}        # invokes the prime skill
       ${BLUE}"run PURE on adding tenant audit logging"${RESET} # full loop with checkpoints
       ${BLUE}"add to doctrine: always state Pydantic v2"${RESET}   # capture a rule

  3. ${YELLOW}Open Cursor or Copilot${RESET} in the same project — they auto-load the
     same doctrine via the symlinks you just set up. No re-explaining your
     stack to a different tool ever again.

${BOLD}${DIM}Yalla — let's build.${RESET}
DONE
