#!/usr/bin/env bash
# Usage: verify.sh [dir]
#
# Checks that a new project has the pieces agents easily miss, for any stack:
# files, toolchain versions, unfilled placeholders, and GitHub repo settings.
# It does not run the project's own checks.

set -uo pipefail

cd "${1:-.}"
failed=0

fail() {
  echo "✗ $1"
  failed=1
}

need() {
  for path in "$@"; do
    [ -e "$path" ] || fail "missing $path"
  done
}

# 1. Common files
need README.md LICENSE AGENTS.md CONTRIBUTING.md .gitignore
need .github/workflows/ci.yml .github/workflows/pr.yml
need .vscode/settings.json .vscode/extensions.json

# 2. Stack files, websites (private packages) are deployed instead of released
if [ -f Cargo.toml ]; then
  need rust-toolchain.toml justfile .rustfmt.toml Cargo.lock .github/workflows/release.yml
fi
if [ -f package.json ]; then
  need .node-version pnpm-lock.yaml vite.config.ts
  for script in check build test; do
    node -e "process.exit(require('./package.json').scripts?.['$script'] ? 0 : 1)" || fail "missing \`$script\` script in package.json"
  done
  if node -e "process.exit(require('./package.json').private ? 1 : 0)"; then
    need .github/workflows/release.yml
  fi
fi

# 3. Placeholders left from templates
if grep -rnE --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=target '\{\{(TODO|[a-z_]+\}\})' .; then
  fail "unfilled placeholders above"
fi

# 4. GitHub repo settings
repo=$(git remote get-url origin 2>/dev/null | sed -nE 's#^(https://|git@)github\.com[:/](.+/[^/]+)$#\2#p' | sed 's/\.git$//')
if [ -z "$repo" ]; then
  echo "- skipped GitHub settings: no GitHub origin"
elif ! settings=$(gh api "repos/$repo" --jq '[.allow_squash_merge, .allow_merge_commit, .allow_rebase_merge, .delete_branch_on_merge, .squash_merge_commit_title, .squash_merge_commit_message, .description // ""] | join(" ")' 2>/dev/null); then
  echo "- skipped GitHub settings: cannot read $repo with gh"
else
  # The description goes last, so it can be empty or contain spaces
  read -r squash merge rebase delete_branch title message description <<<"$settings"
  [ -n "$description" ] || fail "GitHub repo has no description"
  [ "$squash $merge $rebase" = "true false false" ] || fail "GitHub repo should only allow squash merging"
  [ "$delete_branch" = "true" ] || fail "GitHub repo should delete branches on merge"
  [ "$title $message" = "PR_TITLE PR_BODY" ] || fail "GitHub squash commits should use the PR title and description"
fi

[ $failed -eq 0 ] && echo "✓ project verified"
exit $failed
