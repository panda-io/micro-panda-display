#!/usr/bin/env bash
set -e

INSTALL_DIR="${1:-$HOME/.local/bin}"
mkdir -p "$INSTALL_DIR"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Building pimg..."
mpd build

echo "Installing to $INSTALL_DIR/pimg..."
cp bin/pimg "$INSTALL_DIR/pimg"
chmod +x "$INSTALL_DIR/pimg"

# macOS: ad-hoc sign so Gatekeeper doesn't kill the freshly compiled binary.
if [[ "$(uname)" == "Darwin" ]]; then
  codesign --sign - "$INSTALL_DIR/pimg"
fi

echo "Done. Run 'pimg --help' to verify."
