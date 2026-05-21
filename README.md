# Agent Skills Repository

This repository contains my personal custom skills for AI Agentic Coding Assistants (including Antigravity, Claude Code, and Codex). It uses a clean, structured directory layout inspired by `mattpocock/skills` to support easy development, customization, and seamless local installation.

## Repository Structure

All custom skills are located within the `skills/` directory and grouped by context:

```
.
├── README.md
├── CONTEXT.md
├── docs/
│   └── adr/
│       └── 0001-universal-skills-installation.md
├── scripts/
│   └── install.sh                       ← Installation script to link skills locally
└── skills/
    └── engineering/
        └── grill-with-doc/              ← Socratic technical plan grilling skill
            ├── SKILL.md                 ← YAML frontmatter and skill instructions
            ├── ADR-FORMAT.md            ← Architecture Decision Record (ADR) guidelines
            └── CONTEXT-FORMAT.md        ← Domain Glossary (CONTEXT.md) guidelines
```

## Available Skills

### 🛠️ Engineering

*   **[grill-with-doc](file:///Users/nasrunhayeeyama/work/neverholiday/skill/skills/engineering/grill-with-doc/SKILL.md)**: A Socratic sparring partner designed to stress-test your implementation plans against existing code, establish a domain glossary (`CONTEXT.md`), and document critical trade-offs using Architectural Decision Records (ADRs).

### ⚡ Productivity

*   **[git-commit-push](file:///Users/nasrunhayeeyama/work/neverholiday/skill/skills/productivity/git-commit-push/SKILL.md)**: An automated, token-efficient, and precise workflow to interactively stage changes, generate concise Conventional Commits, and push to remote repositories.
*   **[write-a-skill](file:///Users/nasrunhayeeyama/work/neverholiday/skill/skills/productivity/write-a-skill/SKILL.md)**: A structured assistant designed to walk you through standardizing and writing new custom agent skills with proper layouts and progressive disclosure.

## Installation

To install or update these skills so they are available in your preferred AI Agentic Coding Assistant, run the installation script:

```bash
# Default (Installs for Antigravity)
./scripts/install.sh

# Target Claude Code
./scripts/install.sh --platform claude

# Target Codex
./scripts/install.sh --platform codex

# Target all supported platforms at once
./scripts/install.sh --platform all
```

### Options

Use `--help` to view all available parameters:

```
Options:
  -p, --platform NAME Target AI Agent platform: antigravity, claude, codex, all (default: antigravity)
  -d, --dest PATH     Override the destination path for the selected platform (cannot be used with --platform all)
  -u, --uninstall     Remove installed symlinks instead of creating them
  -n, --dry-run       Show what would be done without making actual changes
  -h, --help          Show this help message
```

### How it works
The installation script creates a symlink from each skill directory to the agent's global skills directory (e.g. `~/.gemini/antigravity-cli/skills/`, `~/.claude/skills/`, or `~/.agents/skills/`). Because they are symlinked, any changes you make in this repository are **instantly active** in your CLI sessions without having to re-run the install script!
