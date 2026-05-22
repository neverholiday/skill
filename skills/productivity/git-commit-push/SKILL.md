---
name: git-commit-push
description: Interactively stage changes, generate concise conventional commits with low token usage, and push automatically with upstream configuration. Use when you need to commit and push changes.
---

# Git Commit and Push

An automated, token-efficient, and highly precise workflow for staging local changes, drafting Conventional Commits, and pushing to the remote repository.

## Workflows

### 1. File Inspection & Token-Efficient Status

To prevent excessive token consumption, do **not** run a full `git diff` of the entire repository at the start. Instead, follow this sequence:

1. Run a lightweight status command:
   ```bash
   git status -s
   ```
2. Group the modified and untracked files by logical components or directories.
3. Present the list of modified/untracked files to the user and ask which files/directories they would like to stage:
   > **Note**: If there are only 1-2 small changes, you may proactively ask if they want to stage all of them.

### 2. Selective Staging

Once the user specifies their selection:
1. Stage the selected files:
   ```bash
   git add <selected-files-or-directories>
   ```
2. Retrieve the diff of the staged changes **only** to minimize token payload:
   ```bash
   git diff --cached --stat
   ```
   *If the stat looks small and manageable (e.g., under 150 lines modified), retrieve the exact code diff to formulate the commit message:*
   ```bash
   git diff --cached
   ```
   *If the changes are extremely large, avoid reading the entire diff. Summarize files or query specific small chunks to conserve tokens.*

### 3. Generate a Concise Conventional Commit Message

Formulate a highly precise, extremely concise commit message based strictly on the staged changes:

#### Rules for Conciseness and Precision:
- **Format**: `<type>(<scope>): <short description in imperative mood>`
  - *Types*: `feat` (new feature), `fix` (bug fix), `docs` (documentation), `style` (formatting/linting), `refactor` (code reorganization), `test` (adding/updating tests), `chore` (maintenance/build tasks).
  - *Scope*: Parentheses containing the module, component, or file affected (e.g., `ui`, `installer`, `config`).
  - *Header*: Keep the entire header under 50 characters, completely lowercase, with no period at the end.
- **Body**: Include a body **only** if the changes are multi-faceted or require logical explanation. Keep it to a maximum of 2-3 short, bulleted lines stating the high-level logic (avoid detailed implementation descriptions).
- **Token Efficiency**: Do not include conversational bloat when proposing the commit message.

#### User Review Step:
Present the proposed message to the user for feedback or approval:
```markdown
### Proposed Commit Message
```
feat(scope): short description

- Brief bullet point 1
- Brief bullet point 2
```
Please approve this message or provide modifications.
```

### 4. Committing Changes

Once the user approves the message (or provides edits):
1. Commit the changes using the final approved message:
   ```bash
   git commit -m "<approved-message>"
   ```

### 5. Automated Upstream Push

After committing:
1. Retrieve the current branch name:
   ```bash
   git branch --show-current
   ```
2. Push the branch to the remote repository and set the upstream tracking branch directly:
   ```bash
   git push -u origin <current-branch-name>
   ```
