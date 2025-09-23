#!/bin/bash

# Tmux Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Tmux Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install tmux
print_info "Installing tmux..."
if command -v tmux &> /dev/null; then
    print_success "tmux is already installed: $(tmux -V)"
else
    brew install tmux
    print_success "tmux installed successfully"
fi

# Install Tmux Plugin Manager (TPM)
print_info "Installing Tmux Plugin Manager..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    print_success "TPM is already installed"
else
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    print_success "TPM installed successfully"
fi

# Install reattach-to-user-namespace for macOS clipboard support
print_info "Installing tmux utilities..."
if ! command -v reattach-to-user-namespace &> /dev/null; then
    brew install reattach-to-user-namespace
    print_success "reattach-to-user-namespace installed"
else
    print_info "reattach-to-user-namespace is already installed"
fi

# Setup configuration symlink
print_info "Setting up tmux configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/tmux.conf"
CONFIG_TARGET="$HOME/.tmux.conf"

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
elif [ -L "$CONFIG_TARGET" ]; then
    # Update existing symlink
    ln -sf "$CONFIG_SOURCE" "$CONFIG_TARGET"
    print_success "Configuration symlink updated"
else
    # Create new symlink
    ln -sf "$CONFIG_SOURCE" "$CONFIG_TARGET"
    print_success "Configuration symlink created"
fi

print_footer "Tmux installation completed!"
print_info "Next steps:"
print_info "1. Start tmux with: tmux"
print_info "2. Press 'prefix + I' to install plugins (default prefix is Ctrl-b)"
print_info "3. The configuration includes:"
print_info "   - Mouse support"
print_info "   - Nord theme"
print_info "   - Custom key bindings"
print_info "   - Plugin manager (TPM)"
