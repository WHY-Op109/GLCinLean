# Clean

**Goal.** Keep the local workspace and the remote repository clean and simple, with only the files that the formalisation needs.

**Done when**
- each file that is not needed is deleted, and the commit message names each one with its reason;
- no file refers to a deleted file;
- `STATUS.md` holds only the state that "Workflow" in `AGENTS.md` lists;
- the work is committed and pushed, and the local workspace and the remote repository are in sync.

For each file, ask what it is needed for. Look at the tools in `tools/`, the reports in `notes/` whose findings are applied, and the local files that git ignores. Git history keeps what is deleted.
