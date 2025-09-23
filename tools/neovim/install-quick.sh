#!/bin/bash

# Quick Neovim Installation Script (without plugin installation)
# This script sets up Neovim configuration but skips the problematic plugin installation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Quick Neovim Installation (Configuration Only)"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install Neovim
print_info "Installing Neovim..."
if command -v nvim &> /dev/null; then
    print_success "Neovim is already installed: $(nvim --version | head -n1)"
else
    brew install neovim
    print_success "Neovim installed successfully"
fi

# Install Go (if not already installed)
print_info "Installing Go..."
if command -v go &> /dev/null; then
    print_success "Go is already installed: $(go version)"
else
    brew install go
    print_success "Go installed successfully"
fi

# Install Go development tools
print_info "Installing Go development tools..."

# Set up Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$(go env GOPATH)/bin

# Install essential Go tools
go install golang.org/x/tools/gopls@latest
print_success "gopls (Go Language Server) installed"

go install golang.org/x/tools/cmd/goimports@latest
print_success "goimports installed"

go install github.com/rogpeppe/godef@latest
print_success "godef installed"

go install golang.org/x/tools/cmd/guru@latest
print_success "guru installed"

go install golang.org/x/tools/cmd/gorename@latest
print_success "gorename installed"

go install github.com/cweill/gotests/gotests@latest
print_success "gotests installed"

go install github.com/fatih/gomodifytags@latest
print_success "gomodifytags installed"

go install github.com/josharian/impl@latest
print_success "impl installed"

go install github.com/go-delve/delve/cmd/dlv@latest
print_success "dlv (Delve debugger) installed"

go install github.com/air-verse/air@latest
print_success "air (live reload) installed"

go install mvdan.cc/gofumpt@latest
print_success "gofumpt installed"

go install honnef.co/go/tools/cmd/staticcheck@latest
print_success "staticcheck installed"

# Install golangci-lint
if ! command -v golangci-lint &> /dev/null; then
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.54.2
    print_success "golangci-lint installed"
else
    print_info "golangci-lint is already installed"
fi

# Install additional development tools
print_info "Installing additional development tools..."

# Install ripgrep for fast searching
if ! command -v rg &> /dev/null; then
    brew install ripgrep
    print_success "ripgrep installed"
else
    print_info "ripgrep is already installed"
fi

# Install fd for file finding
if ! command -v fd &> /dev/null; then
    brew install fd
    print_success "fd installed"
else
    print_info "fd is already installed"
fi

# Install fzf for fuzzy finding
if ! command -v fzf &> /dev/null; then
    brew install fzf
    print_success "fzf installed"
else
    print_info "fzf is already installed"
fi

# Install bat for syntax highlighting
if ! command -v bat &> /dev/null; then
    brew install bat
    print_success "bat installed"
else
    print_info "bat is already installed"
fi

# Install tree for directory listing
if ! command -v tree &> /dev/null; then
    brew install tree
    print_success "tree installed"
else
    print_info "tree is already installed"
fi

# Install jq for JSON processing
if ! command -v jq &> /dev/null; then
    brew install jq
    print_success "jq installed"
else
    print_info "jq is already installed"
fi

# Install yq for YAML processing
if ! command -v yq &> /dev/null; then
    brew install yq
    print_success "yq installed"
else
    print_info "yq is already installed"
fi

# Create Neovim configuration directories
print_info "Setting up Neovim configuration directories..."
NVIM_CONFIG_DIR="$HOME/.config/nvim"
ensure_dir "$NVIM_CONFIG_DIR"
ensure_dir "$NVIM_CONFIG_DIR/lua"
ensure_dir "$NVIM_CONFIG_DIR/lua/plugins"
ensure_dir "$NVIM_CONFIG_DIR/lua/config"
ensure_dir "$NVIM_CONFIG_DIR/lua/keymaps"
ensure_dir "$NVIM_CONFIG_DIR/lua/options"
ensure_dir "$NVIM_CONFIG_DIR/lua/autocmds"
ensure_dir "$NVIM_CONFIG_DIR/lua/colorschemes"
ensure_dir "$NVIM_CONFIG_DIR/lsp"
ensure_dir "$NVIM_CONFIG_DIR/after"
ensure_dir "$NVIM_CONFIG_DIR/after/plugin"

# Create backup directories
ensure_dir "$HOME/.local/share/nvim"
ensure_dir "$HOME/.local/share/nvim/backup"
ensure_dir "$HOME/.local/share/nvim/swap"
ensure_dir "$HOME/.local/share/nvim/undo"

# Setup configuration files with symlinks
print_info "Setting up Neovim configuration files with symlinks..."

# Main init.lua
CONFIG_SOURCE="$SCRIPT_DIR/init.lua"
CONFIG_TARGET="$NVIM_CONFIG_DIR/init.lua"

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

# Create symlinks for Lua configuration files
print_info "Creating symlinks for Lua configuration files..."

# Remove existing lua directory if it exists and is not a symlink
if [ -d "$NVIM_CONFIG_DIR/lua" ] && [ ! -L "$NVIM_CONFIG_DIR/lua" ]; then
    print_warning "Existing lua directory found, backing up..."
    mv "$NVIM_CONFIG_DIR/lua" "$NVIM_CONFIG_DIR/lua.backup"
    print_success "Backed up existing lua directory to lua.backup"
fi

# Create symlink to lua directory
ln -sf "$SCRIPT_DIR/lua" "$NVIM_CONFIG_DIR/lua"
print_success "Lua configuration symlink created"

# Create symlink to lsp directory
ln -sf "$SCRIPT_DIR/lsp" "$NVIM_CONFIG_DIR/lsp"
print_success "LSP configuration symlink created"

print_success "Neovim configuration setup completed!"

print_footer "Quick Neovim installation completed!"
print_info "Installed components:"
print_info "  - Neovim (modern Vim fork)"
print_info "  - Go development tools (gopls, goimports, godef, etc.)"
print_info "  - Go debugging tools (dlv, air)"
print_info "  - Code analysis tools (staticcheck, golangci-lint)"
print_info "  - Modern CLI tools (ripgrep, fd, fzf, bat)"
print_info "  - Neovim configuration optimized for Go development"
print_info ""
print_info "Configuration features:"
print_info "  - Modern Lua-based configuration"
print_info "  - Go Language Server Protocol (LSP) support"
print_info "  - Advanced Go development features"
print_info "  - VS Code-like interface and shortcuts"
print_info "  - File explorer and code navigation"
print_info "  - Git integration and debugging support"
print_info "  - Code formatting and linting"
print_info ""
print_info "Next steps:"
print_info "1. Launch Neovim with: nvim"
print_info "2. Plugins will be automatically installed on first launch"
print_info "3. Explore the Go development features"
print_info "4. Check the README.md for detailed usage instructions"
print_info "5. Configuration files are symlinked for easy updates"
print_info ""
print_info "Configuration management:"
print_info "  - All config files are symlinked to this directory"
print_info "  - Changes to config files here will be reflected in Neovim"
print_info "  - To update: git pull in this directory"
print_info "  - To reset: run this install script again"
print_info ""
print_warning "Note: This is a quick installation that skips plugin installation."
print_warning "Plugins will be installed automatically when you first launch Neovim."
