#!/bin/bash
set -eu

. consts.sh

# main
ORIG_IFS=$IFS
IFS="
"

for i in $FILES; do
  source_file=$(echo "$i" | sed -e "s/->/,/" | cut -d "," -f 1)
  dest_file=$(echo "$i" | sed -e "s/->/,/" | cut -d "," -f 2)
  dest_dir=$(dirname $dest_file)

  if [ -e "$dest_dir" ]; then
    echo "install: $source_file -> $dest_file"
    rm -rf $dest_file
    ln -sf $(pwd)/$source_file $dest_file
  else
    printf "${RED}failed${RESET} $source_file: $dest_dir not found\n"
  fi
done

IFS=$ORIG_IFS
