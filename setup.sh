#!/bin/bash
# Creates symbolic links from network bare repo to this scripts repo

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NETWORK_DIR="$HOME/work/network"

echo "Setting up symbolic links for network development scripts..."
echo ""
echo "Script directory: $SCRIPT_DIR"
echo "Network directory: $NETWORK_DIR"
echo ""

# Check if network directory exists
if [ ! -d "$NETWORK_DIR" ]; then
    echo "Error: Network directory does not exist at $NETWORK_DIR"
    exit 1
fi

# Remove existing symlinks or directories if they exist
if [ -L "$NETWORK_DIR/.direnv" ] || [ -e "$NETWORK_DIR/.direnv" ]; then
    echo "Removing existing .direnv..."
    rm -rf "$NETWORK_DIR/.direnv"
fi

if [ -L "$NETWORK_DIR/.envrc" ] || [ -e "$NETWORK_DIR/.envrc" ]; then
    echo "Removing existing .envrc..."
    rm -f "$NETWORK_DIR/.envrc"
fi

# Create directory symlink for .direnv
echo "Creating directory symlink: $NETWORK_DIR/.direnv -> $SCRIPT_DIR/.direnv"
ln -sf "$SCRIPT_DIR/.direnv" "$NETWORK_DIR/.direnv"

# Create file symlink for .envrc
echo "Creating file symlink: $NETWORK_DIR/.envrc -> $SCRIPT_DIR/.envrc"
ln -sf "$SCRIPT_DIR/.envrc" "$NETWORK_DIR/.envrc"

echo ""
echo "Symlinks created successfully:"
echo "  $NETWORK_DIR/.direnv -> $SCRIPT_DIR/.direnv"
echo "  $NETWORK_DIR/.envrc -> $SCRIPT_DIR/.envrc"
echo ""

# Verify symlinks
if [ -L "$NETWORK_DIR/.direnv" ] && [ -L "$NETWORK_DIR/.envrc" ]; then
    echo "Verification: Symlinks are valid"
else
    echo "Warning: Symlinks may not have been created correctly"
    exit 1
fi

# Reload direnv if installed
if command -v direnv &> /dev/null; then
    echo ""
    echo "Reloading direnv..."
    cd "$NETWORK_DIR"
    direnv allow
    echo "direnv reloaded successfully"
else
    echo ""
    echo "Note: direnv not found. You may need to reload it manually:"
    echo "  cd $NETWORK_DIR && direnv allow"
fi

echo ""
echo "Setup complete!"
