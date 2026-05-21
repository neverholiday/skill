# Agent Skills Repository

A local workspace for creating, managing, and installing custom assistant skills for AI Agentic Coding Assistants (e.g., Antigravity, Claude Code, Codex).

## Language

**Skill**:
A modular instruction set, containing a `SKILL.md` file and optional supporting files, designed to extend the capabilities of an AI Agentic Coding Assistant.
_Avoid_: Extension, plugin, tool

**Symlink Installation**:
The process of linking a local skill directory to the target AI Agent's search path, allowing live updates to be instantly reflected.
_Avoid_: Hard installation, copying, binary install

**Destination Path**:
The target directory where a specific AI Agent searches for active skills.
_Avoid_: Target folder, skills folder
