---
name: to-prd
description: Generate a detailed, highly professional Product Requirement Document (PRD) in docs/prd.md. Supports Personal Mode (deep technical specs) and Workplace Mode (traced to PO objectives, Figma designs, and DoD).
---

# Product Requirement Document (PRD) Skill

This skill guides the AI Agent to create or update a structured, high-quality, professional `docs/prd.md` document for your project.

## Quick Start

1. Identify your mode:
   - **Personal Mode:** When building side-projects or independent tools and you need a deep, technical design specification.
   - **Workplace Mode:** When working with Product Owner specs (DoD, Figma designs, product objectives) and you need to ensure strict traceability from PO spec to the PRD.
2. To run, tell the AI:
   - *"Generate PRD in Personal Mode using docs/personal-idea.md"*
   - OR *"Generate PRD in Workplace Mode using docs/po-spec.md"*

---

## Workflow - Workplace Mode (Traceable Spec)

Use this pathway when there are pre-existing Figma designs, objectives, and Definitions of Done from your Product Owner.

### 1. Gather PO Inputs
Ensure the user has provided or created a spec file (e.g. `docs/po-spec.md` or in-context notes) containing:
- **Product Objective:** What business problem are we solving?
- **Figma / Prototype links:** URLs to screens and UI mockups.
- **Definition of Done (DoD):** PO's acceptance criteria (e.g. "User must receive a verification email", "Must handle payment failures").

### 2. Generate Traceability Matrix
At the top of the generated `docs/prd.md`, build a markdown table linking the PO's requirements to specific sections of the PRD:

| PO Requirement / DoD ID | Figma Screen / Link | PRD Section | Description / Core Logic |
| :--- | :--- | :--- | :--- |
| `OBJ-1` / `DOD-1` | [Figma Login Page](https://...) | [Section 3.1: Login Flow](#31-login-flow) | Handles standard email login and password validation |
| `DOD-2` | [Figma Dashboard](https://...) | [Section 4.2: Overview](...) | Displays high-level analytics charts |

### 3. Traceable Product Specification Structure
Create the PRD using the following layout:
1. **Title & Document Metadata:** (Author, Date, Status, Version)
2. **Product Goal & Objective:** Direct mapping to PO's objective.
3. **Traceability Matrix:** The table generated in Step 2.
4. **Core User Flows & Features:** Step-by-step description of user actions with links to corresponding Figma screens.
5. **Business KPIs & Product Analytics:** Define tracking events (e.g., Mixpanel/Segment events, user action metrics) to measure the success of the PO's objectives.
6. **Non-Functional Requirements:** Performance, security, accessibility, and local monitoring rules.

---

## Workflow - Personal Mode (Deep Technical Spec)

Use this pathway when you are designing a project from scratch and need the AI coder to act as a Staff Engineer.

### 1. Read Project Concept
Read the initial project concept from a local idea brief (e.g., `docs/personal-idea.md`) or in-context prompt.

### 2. Generate Deep Technical PRD
Produce a highly technical, rigorous document in `docs/prd.md` containing:
1. **Goal & Scope:** Clear definition of what is in-scope and out-of-scope.
2. **System Architecture Diagram:** A Mermaid.js flowchart or sequence diagram illustrating the system components.
3. **Database Schema:** Detailed relational or document schema definition with field types, constraints, and relationships.
4. **API Design / Contract:** JSON request/response payloads, endpoint paths, method types, and query parameters.
5. **Security & Performance Specifications:** Authentication, encryption, rate-limiting, and performance targets (e.g. latency, page load speed).
6. **Monitoring & Observability:**
   - **APM Integration:** Recommendations for tools like Sentry, Datadog, or OpenTelemetry.
   - **Logging Standards:** Log levels, structured JSON format, and essential log contexts.
   - **Alerting & Thresholds:** Recommended alert criteria (e.g., API error rate > 1% in 5 min).

---

## Formatting Guidelines

1. **Aesthetics:** Use clean markdown, tables, alert callouts (e.g. `> [!IMPORTANT]`), and Mermaid diagrams to make the document highly professional and readable.
2. **No Placeholders:** Write concrete, complete content. If a section is undecided, outline the options instead of using placeholders.
3. **Updates:** If updating an existing PRD, preserve any active traceability tables and only update the modified sections to avoid losing mapping details.
