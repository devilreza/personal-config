#!/bin/bash

# Zed IDE Installation and Configuration Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Zed IDE Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install Zed
print_info "Installing Zed IDE..."
if [ -d "/Applications/Zed.app" ]; then
    print_success "Zed is already installed"
else
    brew install --cask zed
    print_success "Zed IDE installed successfully"
fi

# Create Zed config directory
ZED_CONFIG_DIR="$HOME/.config/zed"
ensure_dir "$ZED_CONFIG_DIR"

# Setup configuration symlink
print_info "Setting up Zed configuration..."

# Function to link a config file
link_config() {
    local filename=$1
    local source_file="$SCRIPT_DIR/$filename"
    local target_file="$ZED_CONFIG_DIR/$filename"

    if [ ! -f "$source_file" ]; then
        return
    fi

    if [ -e "$target_file" ] && [ ! -L "$target_file" ]; then
        print_warning "Existing config found at $target_file"
        read -p "Do you want to backup and replace it? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$target_file" "$target_file.backup"
            print_success "Backed up existing config to $target_file.backup"
            ln -sf "$source_file" "$target_file"
            print_success "Configuration symlink created for $filename"
        else
            print_info "Keeping existing configuration for $filename"
        fi
    else
        # Create or update symlink
        ln -sf "$source_file" "$target_file"
        print_success "Configuration symlink created/updated for $filename"
    fi
}

# Link settings.json
link_config "settings.json"

# Link keymap.json (if it exists in the repo)
link_config "keymap.json"

print_footer "Zed IDE installation completed!"
print_info "Installed components:"
print_info "  - Zed IDE"
print_info "  - Configuration symlinks"
print_info ""
print_info "You can now launch Zed and your settings will be applied automatically."
