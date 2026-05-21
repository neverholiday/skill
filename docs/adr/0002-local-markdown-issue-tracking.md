# 0002. Local Markdown Issue Tracking

**Status:** accepted

We decided to prioritize a local-markdown-first approach for managing and tracking development issues. 

Instead of writing custom API clients to directly integrate with Notion or GitHub during task breakdown, the `to-issues` skill will generate individual, standard markdown files in the `docs/issues/` directory.

### Context and Trade-offs
- **Simplicity:** Zero setup, API keys, or network connections are required. The skill remains lightweight and fully offline-capable.
- **Portability:** Markdown files are standard and can be read/edited by any text editor, AI coder, or developer.
- **Traceability:** Metadata in YAML frontmatter explicitly links each issue file back to its specific section of the PRD (`docs/prd.md`).
- **Future Integration:** Since the issues are structured with clean YAML frontmatter (ID, title, assignee, status, prd_link), they are perfectly prepped for any future automation, sync script, or import tool (e.g. exporting to Notion database or GitHub Issues via a helper script).
