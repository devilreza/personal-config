#!/bin/bash

# Git Tools Installation Script
# Installs git diff tools, commitizen, and standard-version

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Git Tools Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Ensure git is installed
print_info "Checking Git installation..."
if ! command -v git &> /dev/null; then
    brew install git
    print_success "Git installed"
else
    print_success "Git is already installed: $(git --version)"
fi

# Install delta - Better git diff
print_info "Installing delta (better git diff)..."
if command -v delta &> /dev/null; then
    print_success "delta is already installed"
else
    brew install git-delta
    print_success "delta installed successfully"
    
    # Configure git to use delta
    git config --global core.pager delta
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
    git config --global delta.light false
    git config --global delta.side-by-side true
    git config --global delta.line-numbers true
    print_success "delta configured as git pager"
fi

# Install diff-so-fancy (alternative diff tool)
print_info "Installing diff-so-fancy..."
if command -v diff-so-fancy &> /dev/null; then
    print_success "diff-so-fancy is already installed"
else
    brew install diff-so-fancy
    print_success "diff-so-fancy installed"
    print_info "To use diff-so-fancy instead of delta, run:"
    print_info "  git config --global core.pager 'diff-so-fancy | less --tabs=4 -RFX'"
fi

# Install tig - Text-mode interface for git
print_info "Installing tig (git repository browser)..."
if command -v tig &> /dev/null; then
    print_success "tig is already installed"
else
    brew install tig
    print_success "tig installed successfully"
fi

# Install lazygit - Terminal UI for git
print_info "Installing lazygit (Terminal UI for git)..."
if command -v lazygit &> /dev/null; then
    print_success "lazygit is already installed"
else
    brew install lazygit
    print_success "lazygit installed successfully"
fi

# Install gh - GitHub CLI
print_info "Installing GitHub CLI..."
if command -v gh &> /dev/null; then
    print_success "GitHub CLI is already installed"
else
    brew install gh
    print_success "GitHub CLI installed successfully"
fi

# Install commitizen and git-cz
print_info "Installing commitizen and git-cz..."
if command -v git-cz &> /dev/null; then
    print_success "git-cz is already installed"
else
    # Ensure Node.js is available
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please run install-nodejs.sh first"
        exit 1
    fi
    
    # Install commitizen globally
    npm install -g commitizen
    npm install -g cz-conventional-changelog
    
    # Configure commitizen
    echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc
    
    print_success "commitizen installed and configured"
fi

# Install standard-version
print_info "Installing standard-version..."
if command -v standard-version &> /dev/null; then
    print_success "standard-version is already installed"
else
    npm install -g standard-version
    print_success "standard-version installed successfully"
fi

# Install git extras
print_info "Installing git-extras..."
if command -v git-extras &> /dev/null; then
    print_success "git-extras is already installed"
else
    brew install git-extras
    print_success "git-extras installed (additional git commands)"
fi

# Install git-flow
print_info "Installing git-flow..."
if command -v git-flow &> /dev/null; then
    print_success "git-flow is already installed"
else
    brew install git-flow
    print_success "git-flow installed"
fi

# Configure git aliases
print_info "Setting up useful git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.cz '!git-cz'

# Set up git completion for zsh
print_info "Setting up git completion..."
if ! grep -q 'git completion' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# Git completion is handled by Oh My Zsh git plugin
# Additional git aliases
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gdiff='git diff'
alias lg='lazygit'
EOF
    print_success "Git aliases added to ~/.zshrc"
else
    print_info "Git completion already configured"
fi

print_footer "Git tools installation completed!"
print_info "Installed tools:"
print_info "  - delta (beautiful git diffs)"
print_info "  - diff-so-fancy (alternative diff viewer)"
print_info "  - tig (git repository browser)"
print_info "  - lazygit (Terminal UI for git)"
print_info "  - GitHub CLI (gh)"
print_info "  - commitizen (git-cz for conventional commits)"
print_info "  - standard-version (automated versioning)"
print_info "  - git-extras (additional git commands)"
print_info "  - git-flow (git branching model)"
print_info ""
print_info "Useful commands:"
print_info "  git cz              # Commitizen commit helper"
print_info "  git lg              # Pretty git log"
print_info "  lazygit             # Launch git TUI"
print_info "  tig                 # Browse git repository"
print_info "  standard-version    # Update version and generate changelog"
print_info "  gh pr create        # Create GitHub pull request"
print_info ""
print_info "Restart your terminal or run: source ~/.zshrc"
