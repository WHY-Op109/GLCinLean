# Clean

**Goal.** Keep the local workspace and the remote git repo clean and simple, with only the files that are necessary for the formalisation. This project should be a simple Lean project, which uses prompts for most of the tasks and lets the agent do them.

**Done when**
- every file not needed is deleted, after the owner's permission;
- `STATUS.md` has no content that is meaningless or redundant for the following tasks;
- the work is committed and pushed, and the local workspace and the remote git repo are in sync.

**Steps**
1. Review the project files, including all the tools in `tools/`; tools created by agents are the most likely to be unneeded. For each file, ask what it is needed for. Look also for files that are not necessary, such as caches, reviews, reports and other files.
2. Report back to the owner: for each file, delete it or keep it, with your reasons.
3. Delete only the files that the owner approves.
4. Make `STATUS.md` thinner: remove all the content that is meaningless or redundant for the following tasks, and the history that "Writing" in `AGENTS.md` leaves out. Keep the records that "Writing" in `AGENTS.md` asks for. Keep open questions under "Waiting for the owner".
5. Commit and push.
