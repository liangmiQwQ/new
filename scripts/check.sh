#!/usr/bin/env bash
# Usage: scripts/check.sh [stack...]
# Scaffolds each stack into a temporary directory and runs its own checks,
# so outdated templates fail here instead of in new projects.

set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
stacks=("$@")
[ ${#stacks[@]} -eq 0 ] && stacks=(rust js-lib js-cli)
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

check_rust() {
  just lint
  just fmt
  just test
  cargo bench -p benchmark --no-run
}

check_js() {
  vp run check
  vp run build
  vp run test
}

for stack in "${stacks[@]}"; do
  echo "::group::$stack"
  dest="$work/demo-$stack"
  mkdir -p "$dest"
  git -C "$dest" init -q
  "$root/skills/creating-projects/scripts/scaffold.sh" "$stack" "$dest" liangmiQwQ "demo-$stack" "A demo project"
  (
    cd "$dest"
    git add -A
    case "$stack" in
      rust) check_rust ;;
      js-*) check_js ;;
    esac
    # Formatting and building must not leave tracked changes behind
    git diff --exit-code
  )
  echo "::endgroup::"
done
