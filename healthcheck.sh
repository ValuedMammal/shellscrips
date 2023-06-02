#!/bin/bash

# Script for routine tasks that include calling a few RPCs and
# dumping results to a log file

# here, `labels` is a stand-in for your own source of accounting info
# that produces a value we call `EXPECTED` in check #3 below.
source labels

bcli="/usr/local/bin/bitcoin-cli"
lncli="/usr/local/bin/lncli"

logfile="/home/admin/good-morning"

# Clear previous entries
date > $logfile

# Collect rpc data
$bcli getblockchaininfo > tip.json
npeers=$($bcli getconnectioncount)
$lncli getinfo > info.json
$lncli channelbalance > chan_bal.json
$lncli walletbalance > wallet.json

# Tally checks passed
sum=0

t=0 # not yet synced
c=0 # inactive channel
w=0 # accounting mismatch

# check 1: synced to chain
b=$(jq '.blocks' tip.json)
h=$(jq '.headers' tip.json)
if [[ b -eq h ]]; then
    ((sum++))
else
    ((t++))
fi

# check 2: no inactive channels
inactive=$(jq '.num_inactive_channels' info.json)
if [[ inactive -eq 0 ]]; then
    ((sum++))
else
    ((c++))
fi

# check 3: balances
wallet=$(jq '.total_balance' wallet.json | tr -d '"')
offchain=$(jq '.balance' chan_bal.json | tr -d '"')
total=$((wallet + offchain))
if [[ total -ge $EXPECTED ]]; then
    ((sum++))
else
    ((w++))
fi

# Report result
if [[ sum -ne 3 ]]; then
    if [[ t -eq 1 ]]; then
        echo "warning: we're not synced to chain tip" >> $logfile
    fi
    if [[ c -eq 1 ]]; then
        echo "warning: not all channels active" >> $logfile

    fi
    if [[ w -eq 1 ]]; then
        echo "warning: failed sats accounting" >> $logfile
    fi
    echo "${sum}/3 checks passed" >> $logfile
else
    echo "3/3 checks passed!" >> $logfile
fi

# Populate logfile
{
    # bitcoin-cli connections, info
    echo "bitcoin peers: $npeers"
    cat tip.json

    # lncli info, balances
    head -n16 < info.json
    cat chan_bal.json
    cat wallet.json
    uptime
} >> $logfile

# clean up
rm -f tip.json
rm -f info.json
rm -f chan_bal.json
rm -f wallet.json
