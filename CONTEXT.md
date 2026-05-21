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

**Product Requirement Document (PRD)**:
A formal markdown document specifying product goals, user flows, and technical implementation details, supporting both a personal technical deep-dive and a traceable workplace format.
_Avoid_: Spec sheet, product brief

**Traceability Mapping**:
A tabular or structured system linking development tasks or issues directly to specific sections of a PRD, Product Owner (PO) specs, and Figma designs.
_Avoid_: Ticket linking, reference table

**Definition of Done (DoD)**:
A set of quality and functional criteria (typically provided by the Product Owner in Workplace Mode) that a feature must meet before it is considered complete.
_Avoid_: Completion checklist

**Issue**:
A discrete engineering task represented as a markdown file in a dedicated folder, tracing back directly to a specific section of a PRD.
_Avoid_: Ticket, card
