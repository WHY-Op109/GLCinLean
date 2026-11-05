#!/bin/zsh
# GLCinLean local checks (the CI jobs of A2 run the same steps). From the repository root:
#   scripts/check.sh            build, review checks, tracker
#   scripts/check.sh --faults   also build the fault fixtures and run them
set -eu
cd "${0:A:h}/.."
export LAKE_CONFIG=$PWD/.lake-config/lake-config.toml LAKE_CACHE_DIR=$PWD/.lake/cache
log=$(mktemp -t glc-build)
lake build 2>&1 | tee "$log" | grep -E '^error|Build completed' || true
if grep -q 'Built Mathlib\|Built TauCeti' "$log"; then
  echo "STOP: the build compiled Mathlib or Tau Ceti modules (wrong pin or missing cache); report it" >&2
  exit 3
fi
grep -q 'Build completed successfully' "$log" || { echo "build failed" >&2; exit 1; }
lake exe review --config glc/project.toml all > .lake/review-all.json
echo "review all: ok"
out=$(lake exe tracker --dir blueprint/plans --roots GLCinLean check 2>&1)
echo "$out" | tail -2
if echo "$out" | grep -qi 'stale'; then echo "tracker: stale cache warning (plan errors)" >&2; exit 1; fi
lake exe tracker --dir blueprint/plans --roots GLCinLean lint
if [[ "${1:-}" == "--faults" ]]; then
  lake build GLCinLeanFaults 2>&1 | grep -E '^error|Build completed'
  lake exe review --config glc/project.toml faults glc/faults.toml > .lake/review-faults.json
  echo "fault fixtures: all matched"
  (cd reviewkit && lake build RKToy RKToyBad 2>&1 | grep -E '^error|Build completed' &&
    lake exe review --config test/project.toml faults test/faults.toml > .lake/review-faults.json)
  echo "kit toy tests: all matched"
fi
