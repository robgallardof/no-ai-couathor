#!/bin/sh
# Installs the no-ai-coauthor commit-msg hook (macOS, Linux, Git Bash on Windows).
#   ./install.sh                         global: every repository on this machine
#   ./install.sh --repo PATH             only that repository
#   ./install.sh --uninstall [--repo PATH]
set -e
here=$(cd "$(dirname "$0")" && pwd)
hook="$here/hooks/commit-msg"
marker="no-ai-coauthor"
action=install
repo=

while [ $# -gt 0 ]; do
  case "$1" in
    --repo) repo="${2:?--repo needs a path}"; shift 2 ;;
    --uninstall) action=uninstall; shift ;;
    -h|--help) sed -n '2,5p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $1 (see --help)" >&2; exit 2 ;;
  esac
done

if [ -z "$repo" ]; then
  dir="${XDG_CONFIG_HOME:-$HOME/.config}/git/hooks"
  current=$(git config --global core.hooksPath || true)
else
  # --git-path honours a core.hooksPath already set in the repository
  dir=$(cd "$repo" && p=$(git rev-parse --git-path hooks) && mkdir -p "$p" && cd "$p" && pwd)
fi
target="$dir/commit-msg"

if [ "$action" = uninstall ]; then
  if [ -f "$target" ] && grep -q "$marker" "$target"; then
    rm -f "$target"
    [ -f "$target.bak" ] && mv "$target.bak" "$target"
  fi
  if [ -z "$repo" ] && [ "$current" = "$dir" ]; then
    git config --global --unset core.hooksPath
  fi
  echo "✔ no-ai-coauthor removed from $dir"
  exit 0
fi

if [ -z "$repo" ] && [ -n "$current" ] && [ "$current" != "$dir" ]; then
  echo "core.hooksPath is already set globally to: $current" >&2
  echo "Copy hooks/commit-msg there yourself, or unset it first." >&2
  exit 1
fi

mkdir -p "$dir"
if [ -f "$target" ] && ! grep -q "$marker" "$target"; then
  mv "$target" "$target.bak"
  echo "• existing commit-msg hook saved as $target.bak"
fi
cp "$hook" "$target"
chmod +x "$target"
[ -z "$repo" ] && git config --global core.hooksPath "$dir"
echo "✔ no-ai-coauthor installed in $target"
