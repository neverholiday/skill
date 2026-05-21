#!/usr/bin/env bash
set -euo pipefail

# This script symlinks all custom skills in the repository to the Antigravity
# CLI skills directory, making them immediately active for local use.

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PLATFORM="antigravity"
SKILLS_DEST=""
DEST_OVERRIDDEN=false
UNINSTALL=false
DRY_RUN=false

show_help() {
  cat << EOF
Usage: $(basename "$0") [options]

This script symlinks all custom skills in this repository to the specified AI Agent skills directory.

Options:
  -p, --platform NAME Target AI Agent platform: antigravity, claude, codex, all (default: antigravity)
  -d, --dest PATH     Override the destination path for the selected platform (cannot be used with --platform all)
  -u, --uninstall     Remove installed symlinks instead of creating them
  -n, --dry-run       Show what would be done without making actual changes
  -h, --help          Show this help message
EOF
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p|--platform)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --platform requires an argument" >&2
        exit 1
      fi
      PLATFORM="$2"
      shift 2
      ;;
    -d|--dest)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --dest requires an argument" >&2
        exit 1
      fi
      SKILLS_DEST="$2"
      DEST_OVERRIDDEN=true
      shift 2
      ;;
    -u|--uninstall)
      UNINSTALL=true
      shift
      ;;
    -n|--dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Error: Unknown option $1" >&2
      show_help
      exit 1
      ;;
  esac
done

# Validate platform
case "$PLATFORM" in
  antigravity|claude|codex|all)
    ;;
  *)
    echo "Error: Invalid platform '$PLATFORM'. Supported platforms are: antigravity, claude, codex, all" >&2
    exit 1
    ;;
esac

# Validate conflict
if [ "$PLATFORM" = "all" ] && [ "$DEST_OVERRIDDEN" = true ]; then
  echo "Error: Cannot override destination path (--dest) when installing to all platforms (--platform all)" >&2
  exit 1
fi

get_platform_dest() {
  local p="$1"
  case "$p" in
    antigravity) echo "$HOME/.gemini/antigravity-cli/skills" ;;
    claude)       echo "$HOME/.claude/skills" ;;
    codex)        echo "$HOME/.agents/skills" ;;
    *)            echo "Unknown" ;;
  esac
}

# Resolve target platforms
if [ "$PLATFORM" = "all" ]; then
  TARGET_PLATFORMS=("antigravity" "claude" "codex")
else
  TARGET_PLATFORMS=("$PLATFORM")
fi

# Find all skills to process
skills=()
while IFS= read -r -d '' skill_md; do
  skills+=("$skill_md")
done < <(find "$REPO_DIR/skills" -name SKILL.md -not -path '*/node_modules/*' -print0)

if [ ${#skills[@]} -eq 0 ]; then
  echo "No skills found under $REPO_DIR/skills"
  exit 0
fi

exit_code=0

for p in "${TARGET_PLATFORMS[@]}"; do
  # Determine target destination path for this platform
  if [ "$DEST_OVERRIDDEN" = true ]; then
    platform_dest="$SKILLS_DEST"
  else
    platform_dest="$(get_platform_dest "$p")"
  fi

  echo "=========================================================="
  if [ "$UNINSTALL" = true ]; then
    echo "Uninstalling Custom Skills for platform: $p"
  else
    echo "Installing Custom Skills for platform: $p"
  fi
  echo "Source Repository: $REPO_DIR"
  echo "Destination Path:  $platform_dest"
  if [ "$DRY_RUN" = true ]; then
    echo "Running in DRY-RUN mode (no changes will be made)"
  fi
  echo "=========================================================="

  # Create the skills destination directory if it does not exist and we are installing
  if [ "$UNINSTALL" = false ] && [ "$DRY_RUN" = false ]; then
    mkdir -p "$platform_dest"
  fi

  for skill_md in "${skills[@]}"; do
    skill_src_dir="$(dirname "$skill_md")"
    skill_name="$(basename "$skill_src_dir")"
    skill_target="$platform_dest/$skill_name"

    if [ "$UNINSTALL" = true ]; then
      if [ -L "$skill_target" ]; then
        if [ "$DRY_RUN" = true ]; then
          echo "[Dry-run] Would remove symlink: $skill_target"
        else
          rm "$skill_target"
          echo "✓ Uninstalled skill '$skill_name' (removed symlink)"
        fi
      elif [ -e "$skill_target" ]; then
        # A real file or directory exists instead of a symlink
        echo "❌ Error: Destination exists but is not a symlink: $skill_target" >&2
        echo "   Skipping removal to protect potential manual data." >&2
        exit_code=1
      else
        if [ "$DRY_RUN" = true ]; then
          echo "[Dry-run] Skill '$skill_name' is not installed (no symlink found at $skill_target)"
        fi
      fi
    else
      # Install Mode
      if [ -e "$skill_target" ] && [ ! -L "$skill_target" ]; then
        echo "❌ Error: Destination already exists but is not a symlink: $skill_target" >&2
        echo "   Please manually move or delete this directory before installing." >&2
        exit_code=1
        continue
      fi

      if [ "$DRY_RUN" = true ]; then
        echo "[Dry-run] Would symlink: $skill_target -> $skill_src_dir"
      else
        # Recreate or create the symlink
        ln -sfn "$skill_src_dir" "$skill_target"
        echo "✓ Installed/Linked skill '$skill_name' -> $skill_src_dir"
      fi
    fi
  done
done

echo "=========================================================="
if [ $exit_code -ne 0 ]; then
  echo "Process finished with errors. Please check the log above."
  exit $exit_code
else
  if [ "$DRY_RUN" = true ]; then
    echo "Dry-run finished successfully! No changes were made."
  elif [ "$UNINSTALL" = true ]; then
    echo "Uninstallation successfully completed!"
  else
    echo "Installation successfully completed!"
    echo "All skills are active and updated in real-time."
  fi
fi
echo "=========================================================="
