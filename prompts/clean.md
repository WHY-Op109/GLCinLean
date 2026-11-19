# Clean

**Goal.** Keep the local workspace and the remote repository clean and simple, with only the files that the formalisation needs.

**Done when**
- each file that is not needed is deleted, and the commit message names each one with its reason;
- no file refers to a deleted file;
- `STATUS.md` holds only the state that "Workflow" in `AGENTS.md` lists;
- when the monitor reported low disk space: the free disk space of the session's host is above the limit of `tools/monitor.sh` (`MIN_FREE_GB`), or the reply names what takes the space and why each part is needed;
- the work is committed and pushed, and the local workspace and the remote repository are in sync.

For each file, ask what it is needed for. Look at the tools in `tools/`, the reports in `notes/` whose findings are applied, and the local files that git ignores. Git history keeps what is deleted.

For low disk space, look first at what takes the most space on the host: the build outputs and caches under `.lake`, the worktrees and branches of work that is merged, the temporary files of sessions, and Lean toolchains that neither `lean-toolchain` nor Tau Ceti's `main` names. Delete what belongs to this project. Name in the reply what other projects of the owner may use, and leave it.
