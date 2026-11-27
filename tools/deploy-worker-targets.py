#!/usr/bin/env python3
"""Puts the target list and the author workers of `docs/worker-targets/` on the workers' host.

usage: HOST_SSH='ssh <options> <account>@<host>' tools/deploy-worker-targets.py [--check]

Inputs, all under `docs/worker-targets/`:
  targets.md         the target list (the format of TauCetiWorker's `docs/target-lists.md`)
  workers.tsv        one author worker per line: id, roadmap area, `on` or `off`
  notes/<Area>.txt   what Tau Ceti main has for the area; it becomes the worker's `extra_roadmap_prompt`

The script reads the host's `workers.toml`, writes one entry per line of `workers.tsv`, drops
unlisted `author-` entries and keeps the other workers. It sets `github_account` for every worker
and sets the model and pace of `repair` and `maintenance` as described below.

`AGENT` is the agent of the author workers and of `repair`: `claude` (Claude, `author_effort = "high"`)
or `codex` (Codex at the Worker's default model and effort, so no `author_model` and no
`author_effort`). With `codex`, the author workers, `repair` and `maintenance` run until the
provider's limit (`pace = "0:100"`); with `claude`, they keep the last 5% of the week (`PACE`).
`reviewer` runs up to the Codex provider's limit (`pace_codex = "0:100"`).
It checks the list with `tauceti _targets-inspect` and the settings with `tauceti workers apply
--check` on the host, and only then replaces the two files and runs `tauceti workers apply`.
A worker reads the list at the start of each round, and the Worker restarts a changed worker after
its round. A worker that is no longer in `workers.tsv` stops at once, also in the middle of a round:
set it to `off` first and drop its line when it is between rounds. With `--check` nothing on the
host changes.

`HOST_SSH` is the command that runs a shell command on the host. It is not stored in the repository.
"""
import json
import os
import pathlib
import re
import shlex
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent / "docs" / "worker-targets"
REMOTE_DIR = "$HOME/.config/tauceti"
TAUCETI = "$HOME/.local/bin/tauceti"
GITHUB_ACCOUNT = "WHY-Op109"
AGENT = "codex"
PACE = "0:95,90:95" if AGENT == "claude" else "0:100"
PROMPT_LIMIT = 4096


def host(command, data=None):
    """Runs `command` in a shell on the host and returns its output."""
    prefix = os.environ.get("HOST_SSH")
    if not prefix:
        sys.exit("HOST_SSH is not set")
    result = subprocess.run(shlex.split(prefix) + [command], input=data, capture_output=True, text=True)
    if result.returncode != 0:
        sys.exit(f"host command failed ({command[:60]}…): {result.stdout[-400:]}{result.stderr[-400:]}")
    return result.stdout


def author_entry(worker, area, enabled, targets_path):
    lines = [
        f'id = "{worker}"',
        f'github_account = "{GITHUB_ACCOUNT}"',
        f"enabled = {'true' if enabled else 'false'}",
        'only = ["rebase", "fix-ci", "fix", "roadmap"]',
        "auto_refresh = true",
        f'roadmap_only = "{area}"',
        f"roadmap_targets = {json.dumps(targets_path)}",
        "full_quality = true",
    ]
    notes = ROOT / "notes" / f"{area}.txt"
    if notes.exists():
        text = " ".join(notes.read_text().split())
        if len(text) > PROMPT_LIMIT:
            sys.exit(f"{notes}: {len(text)} characters, the limit is {PROMPT_LIMIT}")
        lines.append("extra_roadmap_prompt = " + json.dumps(text, ensure_ascii=False))
    return "\n".join(lines + model_lines(AGENT)) + "\n"


def model_lines(agent):
    """The lines of a worker's entry that set its agent, its effort and its pace."""
    return [f'agent = "{agent}"'] + (['author_effort = "high"'] if agent == "claude" else []) + [f'pace = "{PACE}"']


def retained_entry(block):
    """Pin a retained worker's GitHub account and set its model or pace where specified."""
    worker = re.search(r'(?m)^id = "([^"]+)"', block).group(1)
    block = re.sub(r"(?m)^[ \t]*github_account[ \t]*=[^\n]*(?:\n|$)", "", block)
    block = f'github_account = "{GITHUB_ACCOUNT}"\n' + block
    if worker == "reviewer":
        block = re.sub(r"(?m)^[ \t]*pace_codex[ \t]*=[^\n]*(?:\n|$)", "", block)
        return 'pace_codex = "0:100"\n' + block
    if worker not in ("repair", "maintenance"):
        return block
    agent = AGENT if worker == "repair" else "codex"
    lines = [l for l in block.rstrip("\n").split("\n") if not re.match(r"(agent|author_effort|author_model|pace) =", l)]
    return "\n".join(lines + model_lines(agent)) + "\n"


def main():
    check_only = "--check" in sys.argv[1:]
    rows = []
    for line in (ROOT / "workers.tsv").read_text().splitlines():
        if line.strip() and not line.startswith("#"):
            worker, area, state = line.split()
            if not worker.startswith("author-") or state not in ("on", "off"):
                sys.exit(f"workers.tsv: bad line: {line}")
            rows.append((worker, area, state == "on"))
    targets = (ROOT / "targets.md").read_text()
    areas = set(re.findall(r"(?m)^## ([A-Za-z0-9_-]+)\s*$", targets))
    for worker, area, enabled in rows:
        if enabled and area not in areas:
            sys.exit(f"workers.tsv: {worker}: the target list has no area {area}")

    home = host("printf %s \"$HOME\"")
    targets_path = f"{home}/.config/tauceti/targets.md"
    current = host(f"cat {REMOTE_DIR}/workers.toml")
    head, *blocks = re.split(r"(?m)^\[\[workers\]\]\n", current)
    kept = [b for b in blocks if not re.search(r'(?m)^id = "author-', b)]
    entries = [retained_entry(b.rstrip("\n") + "\n") for b in kept] + [author_entry(w, a, e, targets_path) for w, a, e in rows]
    new = head + "".join("[[workers]]\n" + e + "\n" for e in entries)

    host(f"cat > {REMOTE_DIR}/targets.md.new", targets)
    host(f"cat > {REMOTE_DIR}/workers.toml.new", new)
    summary = json.loads(host(f"{TAUCETI} _targets-inspect --file {targets_path}.new"))["summary"]
    print("target list:", summary)
    # No pipe here: `host` stops the script when the check refuses the settings.
    print(host(f"{TAUCETI} workers --config {REMOTE_DIR}/workers.toml.new apply --check 2>&1").strip().splitlines()[-1])
    if check_only:
        host(f"rm -f {REMOTE_DIR}/targets.md.new {REMOTE_DIR}/workers.toml.new")
        print("checked; nothing changed on the host")
        return
    host(
        f"cd {REMOTE_DIR} && cp -p workers.toml workers.toml.before-deploy && mv targets.md.new targets.md"
        " && mv workers.toml.new workers.toml"
    )
    print(host(f"{TAUCETI} workers apply 2>&1").strip().splitlines()[-1])
    for worker, area, enabled in rows:
        print(f"{worker}: {area}, {'on' if enabled else 'off'}")


if __name__ == "__main__":
    main()
