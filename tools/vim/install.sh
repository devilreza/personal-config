#!/bin/bash

# Vim Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Vim Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install vim
print_info "Installing Vim..."
if command -v vim &> /dev/null; then
    print_success "Vim is already installed: $(vim --version | head -n1)"
else
    brew install vim
    print_success "Vim installed successfully"
fi

# Install MacVim for GUI support (optional)
print_info "Installing MacVim (GUI version)..."
if command -v mvim &> /dev/null; then
    print_success "MacVim is already installed"
else
    brew install macvim
    print_success "MacVim installed successfully"
fi

# Install Vim runtime (Ultimate vimrc)
print_info "Installing Ultimate vimrc..."
VIM_RUNTIME_DIR="$HOME/.vim_runtime"
if [ -d "$VIM_RUNTIME_DIR" ]; then
    print_success "Ultimate vimrc is already installed"
else
    git clone --depth=1 https://github.com/amix/vimrc.git "$VIM_RUNTIME_DIR"
    sh "$VIM_RUNTIME_DIR/install_awesome_vimrc.sh"
    print_success "Ultimate vimrc installed"
fi

# Install additional vim plugins dependencies
print_info "Installing vim plugin dependencies..."

# Install ctags for code navigation
if ! command -v ctags &> /dev/null; then
    brew install ctags
    print_success "ctags installed"
else
    print_info "ctags is already installed"
fi

# Install the_silver_searcher (ag) for fast searching
if ! command -v ag &> /dev/null; then
    brew install the_silver_searcher
    print_success "the_silver_searcher (ag) installed"
else
    print_info "the_silver_searcher is already installed"
fi

# Create vim directories
ensure_dir "$HOME/.vim"
ensure_dir "$HOME/.vim/undodir"
ensure_dir "$HOME/.vim/backup"
ensure_dir "$HOME/.vim/swap"

# Setup configuration symlink
print_info "Setting up vim configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/vimrc"
CONFIG_TARGET="$HOME/.vimrc"

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

print_footer "Vim installation completed!"
print_info "Installed components:"
print_info "  - vim (Vi IMproved)"
print_info "  - MacVim (GUI version)"
print_info "  - Ultimate vimrc configuration"
print_info "  - ctags (code navigation)"
print_info "  - the_silver_searcher (fast file searching)"
print_info ""
print_info "Next steps:"
print_info "1. Launch vim and explore the configuration"
print_info "2. Check :PluginList for available plugins"
print_info "3. Use :PluginInstall to install additional plugins"
