#!/bin/bash

IN="$1"
DEL="$2"
for i in $(echo $IN | tr "$DEL" "\n")
do
  echo $i
done
