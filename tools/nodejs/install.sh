#!/bin/bash

# Node.js Installation Script with NVM

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Node.js Installation with NVM"

# Check if running on macOS
check_macos

# Install NVM
print_info "Installing NVM (Node Version Manager)..."
if [ -d "$HOME/.nvm" ]; then
    print_success "NVM is already installed"
else
    # Download and install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    print_success "NVM installed successfully"
fi

# Add NVM to shell profile if not already added
if ! grep -q 'NVM_DIR' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF
    print_success "NVM configuration added to ~/.zshrc"
else
    print_info "NVM configuration already exists in ~/.zshrc"
fi

# Source NVM for current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS version of Node.js
print_info "Installing latest LTS version of Node.js..."
if command -v node &> /dev/null; then
    print_success "Node.js is already installed: $(node --version)"
    print_info "NPM version: $(npm --version)"
else
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    print_success "Node.js LTS installed and set as default"
fi

# Install useful global npm packages
print_info "Installing useful global npm packages..."
npm install -g yarn pnpm npm-check-updates

print_footer "Node.js installation completed!"
print_info "Installed packages:"
print_info "  - yarn: Modern package manager"
print_info "  - pnpm: Fast, disk space efficient package manager"
print_info "  - npm-check-updates: Update package.json dependencies"
print_info ""
print_info "Please restart your terminal or run: source ~/.zshrc"
