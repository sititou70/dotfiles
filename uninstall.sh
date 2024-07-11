#!/bin/sh
set -eu
cd $(dirname $0)

. ./consts.sh

# main
print_args() {
  for arg in "$@"; do
    echo "$arg"
  done
}

echo "$FILES" | while read -r item; do
  [ "$item" = "" ] && continue

  dest_pattern=$(echo "$item" | sed -e "s/ -> /:/" | cut -d ":" -f 2)
  dest_file=$(basename "$dest_pattern")
  dest_dir_pattern=$(dirname "$dest_pattern")

  eval "print_args $dest_dir_pattern" | while read -r dest_dir; do
    if [ -e "$dest_dir" ]; then
      rm -rf "$dest_dir/$dest_file"
      echo "uninstalled: $dest_dir/$dest_file"
    fi
  done
done
