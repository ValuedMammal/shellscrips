#!/bin/bash
set -euo pipefail

# Script that fetches a remote PR branch, and checks it out.
# Note: it's assumed the remote origin is named 'origin',
# and that all local PR branches should be called 'pull/<N>'
# where 'N' is the PR number.

# Usage: $ `review <N>`

# A generic error
function oops() {
    echo "$1"
    exit 1
}

# Checks for positional args
if [ $# -eq 0 ]; then
    oops "Usage: review <N>"
fi

# Checks we're in a git repo
git branch > /dev/null 2>&1 \
    || oops "Err: must be in a git repo"

n=$1
git fetch origin pull/"${n}"/head:pr/"${n}" \
    && git switch pr/"${n}"

