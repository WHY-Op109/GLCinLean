#!/usr/bin/env python3
"""Check the Mathlib and Tau Ceti declarations that the plan names against the pinned sources.

Run from the root of the repository:

    python3 tools/check-upstream-names.py [PACKAGES_DIR]

`PACKAGES_DIR` is the folder that holds the pinned `mathlib` and `TauCeti` sources; the default is
`.lake/packages`.

The script reads `plans/`, `plans-proof/` and `docs/blueprint-providers.md`. It finds every pair of
a declaration and its module, written as "`Decl` (`Module`)" or as a table row
"| `Decl` | `Module` |". In a list before one module, "`A`, `B` and `C` (`Module`)", every name of
the list is paired with that module. It reports each pair whose module has no source file or whose
module does not declare the name, and it exits with status 1 if it reports a pair.

The check is a scan of the source text that follows `namespace` blocks. It needs no build, so it
also covers the modules that this project does not import.

Limits of the check:

* A name with no module after it is not checked, and neither is a name that contains a space
  (an instance written by its type).
* A name passes when a declared name ends with it after a dot, so a name written without its
  leading namespaces is accepted.
* A declaration that a macro or an attribute generates is not seen.
"""
import os
import re
import sys

MODULE = r"((?:Mathlib|TauCeti)(?:\.[A-Za-z0-9_]+)+)"
NAME = r"`([^`\s]+)`"
SEPARATOR = r"(?:,\s+and\s+|,\s+|\s+and\s+)"
PAIR = re.compile(r"((?:" + NAME + SEPARATOR + r")*)" + NAME + r"\s*\(`" + MODULE + r"`")
ROW = re.compile(r"\|\s*`([^`\s]+)`\s*\|\s*`" + MODULE + r"`\s*\|")
KEYWORD = (
    r"(?:def|theorem|lemma|abbrev|structure|class|instance|inductive|opaque|irreducible_def|alias)"
)
DECLARATION = re.compile(
    r"(?:@\[[^\]]*\]\s*)*"
    r"(?:(?:private|protected|noncomputable|nonrec|unsafe|partial|scoped|local|public|meta)\s+)*"
    + KEYWORD
    + r"\s+(?:\(priority[^)]*\)\s*)?([^\s:({\[]+)"
)


def plan_texts(root):
    """Yield the path and the text of every file that names upstream declarations."""
    for sub in ("plans", "plans-proof"):
        for folder, _, files in os.walk(os.path.join(root, sub)):
            for name in files:
                if name.endswith((".toml", ".md")):
                    path = os.path.join(folder, name)
                    yield path, open(path, encoding="utf-8").read()
    path = os.path.join(root, "docs", "blueprint-providers.md")
    yield path, open(path, encoding="utf-8").read()


def module_file(packages, module):
    """Return the path of the source file of a Mathlib or Tau Ceti module."""
    package = "mathlib" if module.startswith("Mathlib") else "TauCeti"
    return os.path.join(packages, package, *module.split(".")) + ".lean"


def declared_names(path):
    """Return the full names that the file declares, following its `namespace` blocks."""
    source = re.sub(r"/-.*?-/", "", open(path, encoding="utf-8").read(), flags=re.S)
    namespaces = []
    names = set()
    for line in source.split("\n"):
        line = line.strip()
        match = re.match(r"namespace\s+(\S+)", line)
        if match:
            namespaces.append(match.group(1))
            continue
        match = re.match(r"end\s+(\S+)\s*$", line)
        if match and namespaces and namespaces[-1] == match.group(1):
            namespaces.pop()
            continue
        match = DECLARATION.match(line)
        if match:
            short = match.group(1)
            if short.startswith("_root_."):
                names.add(short[len("_root_."):])
            else:
                names.add(".".join(namespaces + [short]))
    return names


def is_declared(names, name):
    """Say if `name` is one of `names`, or one of them without its leading namespaces."""
    return any(full == name or full.endswith("." + name) for full in names)


def main():
    root = "."
    packages = sys.argv[1] if len(sys.argv) > 1 else os.path.join(".lake", "packages")
    pairs = {}
    for path, text in plan_texts(root):
        where = os.path.relpath(path, root)
        for match in PAIR.finditer(text):
            module = match.group(4)
            for name in re.findall(NAME, match.group(1)) + [match.group(3)]:
                pairs.setdefault((module, name), set()).add(where)
        for match in ROW.finditer(text):
            pairs.setdefault((match.group(2), match.group(1)), set()).add(where)
    cache = {}
    failures = 0
    for (module, name), where in sorted(pairs.items()):
        path = module_file(packages, module)
        if not os.path.exists(path):
            print("module has no source file: %s (for `%s`), named in %s" % (module, name, sorted(where)))
            failures += 1
            continue
        if module not in cache:
            cache[module] = declared_names(path)
        if not is_declared(cache[module], name):
            print("not declared: `%s` in %s, named in %s" % (name, module, sorted(where)))
            failures += 1
    print("%d pairs of a declaration and its module; %d not confirmed" % (len(pairs), failures))
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
