#!/bin/sh

spotify=/usr/bin/spotify

if [[ -x $spotify && -x /usr/bin/blockify ]];
then
  blockify &
  block_pid=$!
  $spotify
  trap "kill -9 $block_pid" SIGINT SIGTERM EXIT
fi

