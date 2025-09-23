#!/bin/bash

# Main Installation Script
# Orchestrates the installation of all development tools

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

print_header "Personal Development Environment Setup"

# Check if running on macOS
check_macos

# Function to run installer script
run_installer() {
    local tool_name="$1"
    local script_path="$ROOT_DIR/tools/$tool_name/install.sh"
    
    if [ -f "$script_path" ]; then
        print_header "Installing $tool_name"
        bash "$script_path"
    else
        print_error "Installer not found: $script_path"
        return 1
    fi
}

# Function to prompt for installation
prompt_install() {
    local component="$1"
    local tool_name="$2"
    
    echo ""
    read -p "Install $component? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_installer "$tool_name"
    else
        print_info "Skipping $component"
    fi
}

# Check for Homebrew first
if ! command -v brew &> /dev/null; then
    print_error "Homebrew is not installed!"
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f /opt/homebrew/bin/brew ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Homebrew installed successfully"
fi

# Interactive mode by default
if [ "$1" == "--all" ]; then
    print_info "Installing all components..."
    INTERACTIVE=false
else
    print_info "Interactive installation mode"
    print_info "Use './install-all.sh --all' to install everything without prompts"
    INTERACTIVE=true
fi

# Installation order matters for some dependencies
declare -a tools=(
    "fonts:Nerd Fonts for terminal display"
    "golang:Go (with golangci-lint and mockery)"
    "nodejs:Node.js (with NVM)"
    "python:Python (with pyenv and tools)"
    "docker:Docker and Docker Desktop"
    "ohmyzsh:Oh My Zsh and shell enhancements"
    "tmux:tmux terminal multiplexer"
    "vim:Vim editor with plugins"
    "alacritty:Alacritty terminal emulator"
    "kubernetes-tools:Kubernetes tools (kubectl, oc, k9s, helm)"
    "git-tools:Git tools (delta, commitizen, etc.)"
    "dev-tools:Development tools (protoc, DBeaver, IDEs)"
    "docker-services:Docker services (Redis, PostgreSQL, MySQL)"
)

if [ "$INTERACTIVE" == true ]; then
    for tool_spec in "${tools[@]}"; do
        IFS=':' read -r tool_name tool_desc <<< "$tool_spec"
        prompt_install "$tool_desc" "$tool_name"
    done
else
    # Install all without prompts
    for tool_spec in "${tools[@]}"; do
        IFS=':' read -r tool_name tool_desc <<< "$tool_spec"
        run_installer "$tool_name"
    done
fi

print_footer "Installation completed!"

print_info "Next steps:"
print_info "1. Restart your terminal or run: source ~/.zshrc"
print_info "2. Launch Docker Desktop if you installed Docker"
print_info "3. Configure your Git user:"
print_info "   git config --global user.name \"Your Name\""
print_info "   git config --global user.email \"your.email@example.com\""
print_info "4. Authenticate with GitHub CLI: gh auth login"
print_info "5. Configure cloud CLIs if needed:"
print_info "   - doctl auth init (for DigitalOcean)"
print_info "   - oc login (for OpenShift)"
print_info ""
print_info "Individual tool configurations are in:"
print_info "  $ROOT_DIR/tools/"