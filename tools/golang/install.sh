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

# Uninstall current mockery and install v2.53.5
print_info "Managing mockery installation (downgrading to v2.53.5)..."
if command -v mockery &> /dev/null; then
    current_version=$(mockery --version 2>/dev/null | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' || echo "unknown")
    if [[ "$current_version" == "v2.53.5" ]]; then
        print_success "mockery v2.53.5 is already installed"
    else
        print_info "Current mockery version: $current_version"
        print_info "Uninstalling current mockery version..."

        # Try to uninstall via brew first
        if brew list mockery &> /dev/null; then
            brew uninstall mockery
            print_info "Uninstalled mockery via Homebrew"
        fi

        # Remove any Go-installed version
        if [[ -f "$GOPATH/bin/mockery" ]]; then
            rm -f "$GOPATH/bin/mockery"
            print_info "Removed mockery from GOPATH/bin"
        fi

        # Remove from Go module cache if present
        go clean -modcache

        print_info "Installing mockery v2.53.5..."
        go install github.com/vektra/mockery/v2@v2.53.5
        print_success "mockery downgraded to v2.53.5 successfully"
    fi
else
    print_info "Installing mockery v2.53.5..."
    go install github.com/vektra/mockery/v2@v2.53.5
    print_success "mockery v2.53.5 installed successfully"
fi

print_footer "Golang installation completed!"
print_info "Please restart your terminal or run: source ~/.zshrc"
