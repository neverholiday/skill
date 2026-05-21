#!/usr/bin/env bash
set -euo pipefail

# This script symlinks all custom skills in the repository to
# ~/.gemini/antigravity-cli/skills, making them immediately active for local use.

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DEST="$HOME/.gemini/antigravity-cli/skills"

echo "=========================================================="
echo "Installing Custom Antigravity Skills..."
echo "Source Repository: $REPO_DIR"
echo "Destination Path:  $SKILLS_DEST"
echo "=========================================================="

# Create the skills destination directory if it does not exist
mkdir -p "$SKILLS_DEST"

# Iterate over each SKILL.md under skills/ (excluding nodes/deps)
find "$REPO_DIR/skills" -name SKILL.md -not -path '*/node_modules/*' -print0 |
while IFS= read -r -d '' skill_md; do
  skill_src_dir="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_src_dir")"
  skill_target="$SKILLS_DEST/$skill_name"

  # If the destination exists and is not a symlink, clean it up first
  if [ -e "$skill_target" ] && [ ! -L "$skill_target" ]; then
    rm -rf "$skill_target"
  fi

  # Symlink the skill directory
  ln -sfn "$skill_src_dir" "$skill_target"
  echo "✓ Installed/Linked skill '$skill_name' -> $skill_src_dir"
done

echo "=========================================================="
echo "Installation successfully completed!"
echo "All skills are active and updated in real-time."
echo "=========================================================="
