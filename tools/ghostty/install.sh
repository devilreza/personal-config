#!/bin/bash

# Ghostty Terminal Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Ghostty Terminal Installation"

check_macos
check_homebrew

# Install Ghostty
print_info "Installing Ghostty terminal emulator..."
if [ -d "/Applications/Ghostty.app" ]; then
    print_success "Ghostty is already installed"
else
    brew install --cask ghostty
    print_success "Ghostty installed successfully"
fi

# Create Ghostty config directory
GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
ensure_dir "$GHOSTTY_CONFIG_DIR"

# Setup configuration symlink
print_info "Setting up Ghostty configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/config"
CONFIG_TARGET="$GHOSTTY_CONFIG_DIR/config"

if [ -e "$CONFIG_TARGET" ] && [ ! -L "$CONFIG_TARGET" ]; then
    print_warning "Existing config found at $CONFIG_TARGET"
    read -p "Do you want to backup and replace it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$CONFIG_TARGET" "$CONFIG_TARGET.backup"
        print_success "Backed up existing config to $CONFIG_TARGET.backup"
        ln -sf "$CONFIG_SOURCE" "$CONFIG_TARGET"
        print_success "Configuration symlink created"
    else
        print_info "Keeping existing configuration"
    fi
else
    ln -sf "$CONFIG_SOURCE" "$CONFIG_TARGET"
    print_success "Configuration symlink created/updated"
fi

print_footer "Ghostty installation completed!"
print_info "Restart Ghostty to apply the configuration (or it reloads on save)."
