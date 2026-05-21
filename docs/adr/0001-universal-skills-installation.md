# 0001. Universal Skills Installation Support

**Status:** accepted

We decided to generalize our skills repository to support multiple AI Agentic Coding Assistants (including Antigravity CLI, Claude Code, and Codex) as target platforms. This is implemented via a new `--platform` flag (with choices: `antigravity`, `claude`, `codex`, or `all`) in `scripts/install.sh`, allowing unified symlinking of custom skills to different agent ecosystems while retaining manual path overrides with `--dest`.
