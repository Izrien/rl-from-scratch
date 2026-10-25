#!/bin/sh
# Pre-commit hook: run `mypy src` with this checkout's venv, active or not.
#
# A `language: system` hook resolves its command on PATH. With no venv active,
# PATH can hold another Python's mypy (a global install, say), which would check
# src/ against that Python's packages instead of the project's. So the venv's
# interpreter is found by path, first match wins:
#   1. the active venv, $VIRTUAL_ENV;
#   2. this checkout's .venv;
#   3. the main checkout's .venv: a worktree shares the main checkout's git
#      dir, and pre-commit itself runs from the venv that installed it there.
# Each is tried in the Windows layout (Scripts/python.exe), then the POSIX one
# (bin/python). If none exists the hook fails; it never falls back to PATH.
# CI's Python 3.11 run stays authoritative.
set -eu

top=$(git rev-parse --show-toplevel)
main=$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")

for venv in "${VIRTUAL_ENV:-}" "$top/.venv" "$main/.venv"; do
    [ -n "$venv" ] || continue
    for py in "$venv/Scripts/python.exe" "$venv/bin/python"; do
        if [ -x "$py" ]; then
            echo "mypy-src: $py -m mypy src" >&2
            exec "$py" -m mypy src
        fi
    done
done

echo "mypy-src: no venv found (tried \$VIRTUAL_ENV, $top/.venv and $main/.venv);" \
    "create one as in README.md" >&2
exit 1
