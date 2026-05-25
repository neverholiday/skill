# Agent Skills Repository

A local workspace for creating, managing, and installing custom assistant skills for AI Agentic Coding Assistants (e.g., Antigravity, Claude Code, Codex).

## Language

**Skill**:
A modular instruction set, containing a `SKILL.md` file and optional supporting files, designed to extend the capabilities of an AI Agentic Coding Assistant.
_Avoid_: Extension, plugin, tool

**Symlink Installation**:
The process of linking a local skill directory to the target AI Agent's search path, allowing live updates to be instantly reflected.
_Avoid_: Hard installation, copying, binary install

**Remote Installation**:
The process of transferring and installing a packaged skill to an isolated or remote AI Agent environment (e.g., containerized execution or cloud agents) using utility transfer commands like `curl`.
_Avoid_: Direct symlinking, local mapping


**Destination Path**:
The target directory where a specific AI Agent searches for active skills.
_Avoid_: Target folder, skills folder

**Product Requirement Document (PRD)**:
A formal markdown document specifying problem statements, solutions, user stories, implementation decisions, and testing decisions for a feature, designed to align development before code is written.
_Avoid_: Spec sheet, product brief

**Task**:
A discrete engineering step represented as a markdown file in the `docs/tasks/` directory, tracing back directly to a specific section and User Story of a PRD.
_Avoid_: Issue, ticket, card

**Live-Environment Verification**:
The phase of a Task execution where code is deployed to a developer environment (e.g. symlinked locally or installed remotely) to execute real-world scenarios, capture live logs/errors, and iteratively resolve them before marking the task as done.
_Avoid_: Staging test, manual test, local run

**Design-Aligned Execution**:
The process of implementing code changes (with or without an explicit Task file) while strictly adhering to the architectural constraints in `docs/adr/`, domain glossary in `CONTEXT.md`, and requirements in `docs/prd.md`.
_Avoid_: Free coding, blind coding, unaligned refactoring

**Task Index**:
A markdown document (typically `docs/tasks/README.md`) that lists all generated Tasks, their current status, and basic project progress metrics.
_Avoid_: Task list, backlog summary, issue summary

**Devil's Advocate**:
A specialized skill that critically challenges plans, code, or configuration by identifying hidden assumptions, edge cases, and proposing alternative designs.
_Avoid_: Critic, red team, opposing agent

**Sentinel**:
A custom skill designed for Design-Aligned Execution and Live-Environment Verification, ensuring code modifications (with or without explicit Task files) are strictly guardrailed by the glossary, ADRs, and PRD before and during live deployment testing.
_Avoid_: Task runner, executor, direct coder


