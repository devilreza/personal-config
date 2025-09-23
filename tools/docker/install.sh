#!/bin/bash

# Docker and Docker Desktop Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Docker and Docker Desktop Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install Docker Desktop (includes Docker and Docker Compose)
print_info "Installing Docker Desktop..."
if command -v docker &> /dev/null; then
    print_success "Docker is already installed: $(docker --version)"
    print_success "Docker Compose version: $(docker compose version)"
else
    brew install --cask docker
    print_success "Docker Desktop installed successfully"
    print_info "Please launch Docker Desktop from Applications to complete setup"
fi

# Install Docker Compose standalone (optional, as it's included in Docker Desktop)
print_info "Checking Docker Compose..."
if command -v docker-compose &> /dev/null; then
    print_success "Docker Compose standalone is installed: $(docker-compose --version)"
else
    print_info "Docker Compose is available through Docker Desktop as 'docker compose'"
fi

# Create docker config directory
ensure_dir "$HOME/.docker"

# Add Docker completion to zsh
print_info "Setting up Docker shell completion..."
if ! grep -q 'docker completion' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# Docker completion
if command -v docker &> /dev/null; then
    # Docker CLI completion
    autoload -Uz compinit && compinit
fi
EOF
    print_success "Docker completion added to ~/.zshrc"
else
    print_info "Docker completion already configured"
fi

print_footer "Docker installation completed!"
print_info "Next steps:"
print_info "1. Launch Docker Desktop from Applications"
print_info "2. Sign in to Docker Hub (optional)"
print_info "3. Configure Docker Desktop preferences as needed"
print_info ""
print_info "Useful Docker commands:"
print_info "  docker ps                    # List running containers"
print_info "  docker images               # List images"
print_info "  docker compose up           # Start services defined in docker-compose.yml"
print_info "  docker system prune -a      # Clean up unused resources"
