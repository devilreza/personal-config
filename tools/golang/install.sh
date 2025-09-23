#!/bin/bash

# Golang Installation Script
# Installs Go, golangci-lint, and mockery

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Golang Installation"

# Check if Homebrew is installed
check_homebrew

# Install Go
print_info "Installing Go..."
if command -v go &> /dev/null; then
    print_success "Go is already installed: $(go version)"
else
    brew install go
    print_success "Go installed successfully"
fi

# Set up Go environment variables
print_info "Setting up Go environment..."
if ! grep -q 'export GOPATH' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
EOF
    print_success "Go environment variables added to ~/.zshrc"
else
    print_info "Go environment variables already configured"
fi

# Install golangci-lint
print_info "Installing golangci-lint..."
if command -v golangci-lint &> /dev/null; then
    print_success "golangci-lint is already installed: $(golangci-lint --version)"
else
    brew install golangci-lint
    print_success "golangci-lint installed successfully"
fi

# Install mockery
print_info "Installing mockery..."
if command -v mockery &> /dev/null; then
    print_success "mockery is already installed: $(mockery --version)"
else
    brew install mockery
    print_success "mockery installed successfully"
fi

print_footer "Golang installation completed!"
print_info "Please restart your terminal or run: source ~/.zshrc"
