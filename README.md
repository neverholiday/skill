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
│       ├── 0001-universal-skills-installation.md
│       ├── 0002-local-markdown-issue-tracking.md
│       ├── 0003-unified-prd-structure-and-user-story-traceability.md
│       ├── 0004-devils-advocate-interactive-grilling-skill.md
│       ├── 0005-decoupled-requirement-to-task-workflow.md
│       └── 0006-sentinel-design-aligned-execution-workflow.md
├── scripts/
│   └── install.sh                       ← Installation script to link skills locally
└── skills/
    ├── engineering/
    │   ├── devils-advocate/             ← Interactive sequential plan/code grilling skill
    │   ├── grill-with-doc/              ← Socratic technical plan grilling skill
    │   ├── sentinel/                    ← Design-aligned execution & live verification skill
    │   ├── to-prd/                      ← Unified PRD generation skill based on Matt Pocock's skills
    │   └── to-tasks/                    ← Streamlined task breakdown plan generator
    └── productivity/
        ├── git-commit-push/             ← Automated, token-efficient git workflow skill
        └── write-a-skill/               ← Assistant for writing standardized agent skills
```

## Available Skills

### 🛠️ Engineering

*   **[devils-advocate](skills/engineering/devils-advocate/SKILL.md)**: Critically challenge code, configuration, or plans by identifying edge cases, potential flaws, and alternative approaches in an interactive, sequential grilling format.
*   **[grill-with-doc](skills/engineering/grill-with-doc/SKILL.md)**: A Socratic sparring partner designed to stress-test your implementation plans against existing code, establish a domain glossary (`CONTEXT.md`), and document critical trade-offs using Architectural Decision Records (ADRs).
*   **[sentinel](skills/engineering/sentinel/SKILL.md)**: Enforces Design-Aligned Execution and coordinates Live-Environment Verification feedback loops with or without explicit developer task files.
*   **[to-prd](skills/engineering/to-prd/SKILL.md)**: A unified Product Requirement Document (PRD) generator based on Matt Pocock's skills repository, synthesizing conversation and repository context into a robust PRD without interviews.
*   **[to-tasks](skills/engineering/to-tasks/SKILL.md)**: A streamlined task breakdown skill that parses `docs/prd.md` to generate atomic local tasks under `docs/tasks/` with complete user story traceability.

### ⚡ Productivity

*   **[git-commit-push](skills/productivity/git-commit-push/SKILL.md)**: An automated, token-efficient, and precise workflow to interactively stage changes, generate concise Conventional Commits, and push to remote repositories.
*   **[write-a-skill](skills/productivity/write-a-skill/SKILL.md)**: A structured assistant designed to walk you through standardizing and writing new custom agent skills with proper layouts and progressive disclosure.

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
