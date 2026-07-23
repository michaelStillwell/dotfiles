#!/usr/bin/env bash
set -e

desktop="$1"
if [[ -z "$desktop" ]]; then
  echo "Usage: $0 <file.desktop>"
  exit 1
fi

dir="$HOME/.local/share/applications"
mkdir -p "$dir"

cp "$desktop" "$dir/"

update-desktop-database "$dir"

xdg-settings set default-web-browser "$(basename "$desktop")"

xdg-settings get default-web-browser
