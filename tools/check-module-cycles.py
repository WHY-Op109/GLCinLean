"""Check that no module plan of plans/ imports another in a cycle.

A module plan becomes one Lean file, and Lean does not allow cyclic imports.
`lake exe tracker lint` checks cycles between nodes only, so it does not see these.
Run from the repository root: `python3 tools/check-module-cycles.py`.
It prints each set of module plans that import each other, with the edges
between them, and exits with status 1 if there is one.
"""
import os
import sys
import tomllib

nodes = {}
for d, _, fs in os.walk('plans'):
    for f in fs:
        if f.endswith('.toml'):
            p = os.path.join(d, f)
            for n in tomllib.load(open(p, 'rb')).get('node', []):
                nodes[n['id']] = (p, n.get('deps', []))

graph = {p: set() for p, _ in nodes.values()}
for p, deps in nodes.values():
    graph[p].update(nodes[d][0] for d in deps if d in nodes and nodes[d][0] != p)


def reach(f):
    seen, todo = set(), list(graph[f])
    while todo:
        v = todo.pop()
        if v not in seen:
            seen.add(v)
            todo.extend(graph[v])
    return seen


R = {f: reach(f) for f in graph}
groups = sorted({tuple(sorted(g for g in R if f in R[g] and g in R[f])) for f in R if f in R[f]})
for group in groups:
    print('cycle:', ', '.join(group))
    for i, (p, deps) in sorted(nodes.items()):
        for d in deps:
            if p in group and d in nodes and nodes[d][0] in group and nodes[d][0] != p:
                print('   ', i, '->', d)
print(f'{len(graph)} module plans, {len(nodes)} nodes, {len(groups)} cycles')
sys.exit(1 if groups else 0)
