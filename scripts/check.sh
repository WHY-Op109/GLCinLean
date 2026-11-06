#!/usr/bin/env bash
# GLCinLean checks, as CI runs them. From anywhere in the checkout:
#   scripts/check.sh [--caches]
#     --caches   first fetch the Mathlib and Tau Ceti build caches (a fresh checkout, CI)
# Reports go to .lake/ci/. Exit status: 0 passed, 1 a check failed, 2 bad arguments, 3 the build
# compiled a Mathlib or Tau Ceti module (wrong pin or missing cache: stop and report it).
set -eu
cd "$(dirname "$0")/.."
export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
caches=0
for arg in "$@"; do
  case $arg in
    --caches) caches=1 ;;
    *) echo >&2 "usage: scripts/check.sh [--caches]"; exit 2 ;;
  esac
done
out=$PWD/.lake/ci
mkdir -p "$out"
failed=()

# A compiled module of a cached package ("Built Mathlib.Foo (3s)"); native objects for linking an
# executable ("Built Mathlib.Foo:c.o") are not a source build.
cached_re='(Built|Building) (Mathlib|TauCeti|Batteries|Aesop|Qq|Plausible|ProofWidgets|ImportGraph|LeanSearchClient|Cli)(\.[^ :]*)? '

guarded_build() {  # guarded_build LOG [TARGET...]
  local log=$1; shift
  local st=0
  lake build "$@" > "$log" 2>&1 || st=$?
  if grep -qE "$cached_re" "$log"; then
    grep -E "$cached_re" "$log" | head -5 >&2
    echo >&2 "STOP: the build compiled Mathlib or Tau Ceti modules (wrong pin or missing cache); report it"
    exit 3
  fi
  grep -E '^error' "$log" >&2 || true
  (( st == 0 )) || { echo >&2 "build failed ($log)"; exit 1; }
  tail -1 "$log"
}

check() {  # check NAME CMD...: run a reviewkit-report/0 command, print a summary
  local name=$1; shift
  local st=0
  "$@" > "$out/$name.json" || st=$?
  python3 -I -c '
import json, sys
d = json.load(open(sys.argv[1]))
print(sys.argv[2] + ": ok=" + str(d.get("ok")) + (" setup_error: " + d["setup_error"] if "setup_error" in d else ""))
for r in d.get("reports", []):
    print("  %s: errors=%d warnings=%d" % (r["check"], r["errors"], r["warnings"]))
    for x in r["diagnostics"]:
        if x["severity"] == "error": print("    error [%s] %s" % (x["code"], x["message"][:200]))
' "$out/$name.json" "$name" || st=2
  (( st == 0 )) || failed+=("$name")
}

tracker_warn_re='^(warning: (the cache is |no cache)|the plan has errors)'
tracker() {  # tracker CMD: fails on errors and on the stale-cache warning (exit 0 then)
  local st=0
  lake exe tracker --dir blueprint/plans --roots GLCinLean "$@" > "$out/tracker-$1.out" 2>&1 || st=$?
  tail -2 "$out/tracker-$1.out"
  if (( st != 0 )) || grep -qE "$tracker_warn_re" "$out/tracker-$1.out"; then failed+=("tracker $1"); fi
}

if (( caches )); then
  lake exe cache get > "$out/cache.log" 2>&1 || { tail -5 "$out/cache.log"; exit 1; }
  lake cache get --service tauceti-public --repo TauCetiProject/TauCeti --package TauCeti \
    --mappings-only > "$out/cache-tauceti.log" 2>&1 || { tail -5 "$out/cache-tauceti.log"; exit 1; }
fi

guarded_build "$out/build.log"
check review-all lake exe review --config glc/project.toml all
tracker check
tracker lint
# The closure of the abstract: the key definitions the fidelity review covers (prompts/review.md).
lake exe review --config glc/project.toml closure > "$out/closure.json" || failed+=("closure list")

if (( ${#failed[@]} )); then
  (IFS=,; echo >&2 "FAILED: ${failed[*]}  (reports in .lake/ci/)")
  exit 1
fi
echo "all checks passed"
