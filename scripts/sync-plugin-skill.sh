#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
source_dir="$repo_root/skills/moviola-directing"
target_dir="$repo_root/plugins/moviola-directing/skills/moviola-directing"

if [ "${1:-}" = "--check" ]; then
  diff -qr "$source_dir" "$target_dir"
  exit
fi

if [ -n "${1:-}" ]; then
  echo "usage: $0 [--check]" >&2
  exit 2
fi

staging_dir="${target_dir}.sync.$$"
backup_dir="${target_dir}.backup.$$"

cleanup() {
  rm -rf "$staging_dir" "$backup_dir"
}
trap cleanup EXIT HUP INT TERM

mkdir -p "$staging_dir"
cp -R "$source_dir/." "$staging_dir/"

if [ -d "$target_dir" ]; then
  mv "$target_dir" "$backup_dir"
fi
mv "$staging_dir" "$target_dir"
rm -rf "$backup_dir"

echo "Synced $source_dir -> $target_dir"
