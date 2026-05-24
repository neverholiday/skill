# 0005. Decoupled Requirement and Task Workflow

**Status:** accepted

We decided to decouple the `to-prd` and `to-tasks` skills, establishing a three-phase local-first requirements workflow (Conceptual Alignment, Requirement Formalization, and Execution Planning) with a lightweight, inline versioning system in the PRD.

### Context and Trade-offs
- **Separation of Concerns:** Previously, the `to-prd` skill automatically invoked `to-tasks` at the end of its run. This introduced tight programmatic and operational coupling. By decoupling them, `to-prd` focuses entirely on requirements definition (the *what* and the *why*), while `to-tasks` focuses purely on execution planning (the *how*, *estimate*, and *who*).
- **Avoiding Over-Engineering:** Rather than building automated bridging suggestions or complex interactive checks into the skills, the workflow remains completely manual and decoupled. The developer is empowered to run `/to-tasks` when they are ready.
- **Changelog and Version Control:** To maintain a living document that easily details changes, we introduce a `## Document History` table inside the PRD template utilizing a simple semantic versioning structure (Major.Minor). 
  - *Major changes* (structural, domain model, database paradigm) should be preceded by a `/grill-with-doc` session to protect the big picture.
  - *Minor changes* (additions, small adjustments) can be made directly in `docs/prd.md` by the developer.
  - For both cases, running `/to-tasks` after the update ensures incremental tasks are correctly diffed (`[NEW]`, `[MODIFIED]`, `[DELETED]`).
