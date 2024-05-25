#!/bin/sh
set -eu
cd $(dirname $0)

. ./consts.sh

# main
echo "$FILES" | while read item; do
  [ "$item" = "" ] && continue

  source_file=$(echo "$item" | sed -e "s/ -> /:/" | cut -d ":" -f 1)
  dest_file=$(echo "$item" | sed -e "s/ -> /:/" | cut -d ":" -f 2)
  dest_dir=$(dirname "$dest_file")

  if [ -e "$dest_dir" ]; then
    printf "${GREEN}installed${RESET}: $source_file -> $dest_file\n"
    rm -rf $dest_file
    ln -sf $(pwd)/$source_file $dest_file
  else
    printf "${RED}failed${RESET}:    $source_file: $dest_dir not found\n"
  fi
done
