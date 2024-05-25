#!/bin/sh
set -eu
cd $(dirname $0)

. ./consts.sh

# main
echo "$FILES" | while read item; do
  [ "$item" = "" ] && continue

  dest_file=$(echo "$item" | sed -e "s/ -> /:/" | cut -d ":" -f 2)

  echo uninstalled: "$dest_file"
  rm -rf "$dest_file"
done
