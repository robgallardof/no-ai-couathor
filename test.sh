#!/bin/sh
# Runs the hook against a throwaway repository and checks what survives. Usage: ./test.sh
set -e
here=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
git init -q "$tmp"
git -C "$tmp" config user.name test
git -C "$tmp" config user.email test@example.com
"$here/install.sh" --repo "$tmp" > /dev/null

fail=0
check() { # check <message> <expected>
  git -C "$tmp" commit -q --allow-empty -m "$1"
  got=$(git -C "$tmp" log -1 --format=%B | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}')
  if [ "$got" = "$2" ]; then echo "ok   - $(echo "$2" | head -1)"; else
    echo "FAIL - expected:"; echo "$2"; echo "  got:"; echo "$got"; fail=1; fi
}

check "feat: login

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>" "feat: login"

check "fix: typo

Co-authored-by: Copilot <copilot@github.com>
Co-authored-by: Ana <ana@example.com>" "fix: typo

Co-authored-by: Ana <ana@example.com>"

check "docs: mention Claude in the README" "docs: mention Claude in the README"

check "fix: strip the \"🤖 Generated with Claude Code\" line

The line \"Generated with [Claude Code](...)\" stayed.

Generated with Claude Code.

Co-Authored-By: Claude <noreply@anthropic.com>" "fix: strip the \"🤖 Generated with Claude Code\" line

The line \"Generated with [Claude Code](...)\" stayed."

for agent in OpenCode DeepSeek "DeepSeek Harness"; do
  check "feat: agent support

Generated with $agent

Co-Authored-By: $agent <agent@example.invalid>
Co-Authored-By: Ana <ana@example.invalid>" "feat: agent support

Co-Authored-By: Ana <ana@example.invalid>"
done

check "fix: keep human name

Co-Authored-By: DeepSeek Developer <human@example.invalid>" "fix: keep human name

Co-Authored-By: DeepSeek Developer <human@example.invalid>"

"$here/install.sh" --uninstall --repo "$tmp" > /dev/null
[ ! -f "$tmp/.git/hooks/commit-msg" ] && echo "ok   - uninstall" || { echo "FAIL - uninstall"; fail=1; }
exit $fail
