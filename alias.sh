#!/bin/bash -x

# Script for listing peer aliases,
# disconnecting the peer if `getnodeinfo` returns rpc err

# note: make sure we don't inadvertently disconnect a channel partner.
# assume if we have a channel, then `getnodeinfo` shouldn't fail.
# we can add an explicit check that some pubkey is not in the output of `listchannels`

lncli=$(which lncli)

# Get peers and channels
$lncli listpeers > peers.json
$lncli listchannels > chan.json
sleep 1

# Create list of peer pubs, trimming quotes
jq '.peers[].pub_key' peers.json | tr -d '"' > pubs.txt
sleep 1

npeers=$(< pubs.txt wc -l)
echo "we have $npeers peers"

# Iterate over pubkeys
while read -r pub; do
    $lncli getnodeinfo "$pub" > node.json
    sleep 1

    # make sure we got a result
    if [[ -s node.json ]]; then
        # alias + pubkey pair in the output
        alias=$(jq '.node.alias' node.json | tr -d '"')
        echo "$alias $pub" >> alias.txt
    else
        # add a redundant check that 'pub' is not already a channel parter
        n=$(grep -c "$pub" chan.json)
        if [[ n -eq 0 ]]; then
            # drop unknown peer
            echo "dropping $pub"
            $lncli disconnect "$pub"
        fi
    fi
done < pubs.txt

out=$(< alias.txt wc -l)
dropped=$(("$npeers" - "$out"))
echo "disconnected $dropped peers"

# display result
cat alias.txt

# clean up
rm -f peers.json
rm -f chan.json
rm -f pubs.txt
rm -f node.json
cp alias.txt peer_alias.txt
rm -f alias.txt
