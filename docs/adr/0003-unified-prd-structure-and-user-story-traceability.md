# 0003. Unified PRD Structure and User Story Traceability

**Status:** accepted

We decided to simplify and unify our Product Requirement Document (PRD) creation process by removing the specialized "Personal Mode" and "Workplace Mode" workflows. In their place, we adopt a single, streamlined template matching Matt Pocock's GitHub skills structure, enriched with optional guidelines for system architecture (Mermaid.js sequence diagrams) and monitoring/observability standards. 

Additionally, we integrate this unified PRD with a local `to-tasks` skill (renamed from `to-issues`) to enable clear user story traceability using specific story IDs (`US-X`) mapped to tasks written to `docs/tasks/`.

### Context and Trade-offs
- **Process Simplicity:** Eliminating multiple modes reduces overhead and confusion when using `to-prd`. The AI agent can now generate a single, highly flexible document regardless of context, scaling up with optional technical diagrams and operational specifications when needed.
- **Traceability Mapping:** We introduce explicit User Story identifiers (e.g. `US-1`, `US-2`) in the PRD, which are directly referenced in the YAML frontmatter of generated task markdown files (`user_stories: ["US-1"]`). This ensures strong bi-directional alignment.
- **Eliminating Ticket Overheads:** Triage labels like `ready-for-agent` are removed entirely, shifting the conceptual model of the tool from an enterprise ticketing tracker to a lightweight, single-developer **Task Breakdown & Execution Plan** under `docs/tasks/`.
- **Removed Features:** We deprecate and remove the separate templates for personal idea briefs and workplace specs, making input formats more dynamic and conversational.
