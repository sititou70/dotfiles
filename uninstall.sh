#!/bin/bash
set -eu

. consts.sh

# main
for i in $FILES; do
  dest_file=$(echo "$i" | sed -e "s/->/ /" | cut -d " " -f 2)
  
  echo uninstall: $dest_file
  rm -rf $dest_file
done
