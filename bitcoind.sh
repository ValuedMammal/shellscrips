#!/bin/bash

set -x
set -euo pipefail

killall bitcoind > /dev/null || true

path="${HOME}/Library/Application Support/Bitcoin"

cd "$path"

rm -rf regtest

bitcoind -regtest

sleep 1

# create wallet
bitcoin-cli -regtest createwallet test

# get address
addr=$(bitcoin-cli -regtest getnewaddress)

# mine 101 blocks
bitcoin-cli -regtest generatetoaddress 101 "$addr" > /dev/null
