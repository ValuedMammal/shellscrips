#!/bin/bash
set -euo pipefail

# Watch a mempool transaction and fire an alert on the first confirmation.
# Note, we can use `&` to send the process to the background.

# Usage: `mineconf <TXID> &`

af_path="${HOME}/Downloads/loon-tremolo.mp3"
#af_path="/path/to/your/audio-file.mp3"

if [ $# -lt 1 ]; then
    echo "Usage: mineconf <TXID>"
    exit 1
fi

echo "Awaiting ${1} for 1 confirmation.."
while true; do
    # Query txout
    conf=$(bitcoin-cli -signet gettxout "$1" 0 | jq '.confirmations')

    if [ $conf -gt 0 ]; then
        # Do the thing
        afplay "$af_path"
        break
    fi

    sleep 30
done
