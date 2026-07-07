#!/usr/bin/env bash
set -euo pipefail

# Build all resume PDFs from markdown via pandoc + xelatex.
# Each resume/<name>.md is built to ../<name>.pdf at the repo root, where
# GitHub Pages serves it (e.g. resume.md -> /resume.pdf).
#
# Usage: ./build.sh            # build every *.md in this folder
#        ./build.sh resume.md  # build just one source

cd "$(dirname "$0")"

# Ensure xelatex from BasicTeX/MacTeX is on PATH
if [ -d "/usr/local/texlive/2025basic/bin/universal-darwin" ]; then
  export PATH="/usr/local/texlive/2025basic/bin/universal-darwin:$PATH"
fi

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Error: pandoc not found. Install with: brew install pandoc" >&2
  exit 1
fi

if ! command -v xelatex >/dev/null 2>&1; then
  echo "Error: xelatex not found. Install BasicTeX with: brew install --cask basictex" >&2
  exit 1
fi

# Sources: explicit args, or every markdown file in this folder.
if [ "$#" -gt 0 ]; then
  sources=("$@")
else
  sources=(*.md)
fi

for SRC in "${sources[@]}"; do
  OUT="../${SRC%.md}.pdf"
  echo "Building $OUT from $SRC..."
  pandoc "$SRC" -o "$OUT" --pdf-engine=xelatex
done

echo "Done."
