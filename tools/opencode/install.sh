#!/bin/bash

# opencode CLI Installation and Configuration Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "opencode CLI Installation"

check_macos
check_homebrew

# Install opencode
print_info "Installing opencode CLI..."
if command_exists opencode; then
    print_success "opencode is already installed"
else
    brew install sst/tap/opencode
    print_success "opencode CLI installed successfully"
fi

# Create opencode config directory
OPENCODE_CONFIG_DIR="$HOME/.config/opencode"
ensure_dir "$OPENCODE_CONFIG_DIR"

# Setup configuration symlink
print_info "Setting up opencode configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/opencode.json"
CONFIG_TARGET="$OPENCODE_CONFIG_DIR/opencode.json"

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

print_footer "opencode installation completed!"
print_info "Installed components:"
print_info "  - opencode CLI"
print_info "  - Configuration symlink (~/.config/opencode/opencode.json -> repo)"
print_info ""
print_info "You can now run 'opencode' and your settings will be applied automatically."
