#!/bin/sh
set -eu

artifact_dir="${1:-artifacts}"
expected="${EXPECTED_ARTIFACTS:-main.pdf apresentacao.pdf}"
failed=0

for artifact in $expected; do
    path="$artifact_dir/$artifact"
    pages=""
    if [ -s "$path" ]; then
        pages="$(pdfinfo "$path" 2>/dev/null | awk '/^Pages:/ { print $2 }')"
    fi

    if [ -n "$pages" ] && [ "$pages" -gt 0 ]; then
        printf 'ok - %s (%s pages)\n' "$artifact" "$pages"
    else
        printf 'not ok - %s\n' "$artifact" >&2
        failed=1
    fi
done

test "$failed" -eq 0
