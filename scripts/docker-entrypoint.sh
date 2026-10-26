#!/bin/sh
# Explicit one-shot compatibility filter; never installs hooks or host configuration.
set -eu
if [ "$#" -eq 1 ] && { [ "$1" = "--help" ] || [ "$1" = "-h" ]; }; then
  printf '%s\n' 'Deprecated: use RepoRinse for new installations.' \
    'Usage: no-ai-coauthor PATH_TO_MESSAGE (within /repo)' \
    'Edits the mounted message in place. No hook installation or network.'
  exit 0
fi
if [ "$#" -ne 1 ]; then
  printf '%s\n' 'Expected exactly one message path within /repo; see --help.' >&2
  exit 2
fi
case "$1" in
  /*) candidate="$1" ;;
  *) candidate="/repo/$1" ;;
esac
message=$(realpath "$candidate")
case "$message" in
  /repo/*) ;;
  *) printf '%s\n' 'The message must stay inside /repo.' >&2; exit 2 ;;
esac
if [ ! -f "$message" ] || [ ! -w "$message" ]; then
  printf '%s\n' 'The message must be an existing writable regular file.' >&2
  exit 2
fi
exec sh /usr/local/lib/no-ai-coauthor/commit-msg "$message"
