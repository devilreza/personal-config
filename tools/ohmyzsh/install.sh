#!/bin/bash

# Oh My Zsh and Plugins Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Oh My Zsh and Plugins Installation"

# Check if running on macOS
check_macos

# Install Oh My Zsh
print_info "Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_success "Oh My Zsh is already installed"
else
    # Install Oh My Zsh without launching a new shell
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed successfully"
fi

# Install Powerlevel10k theme
print_info "Installing Powerlevel10k theme..."
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
    print_success "Powerlevel10k theme is already installed"
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    print_success "Powerlevel10k theme installed"
fi

# Install zsh-autosuggestions plugin
print_info "Installing zsh-autosuggestions plugin..."
AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ -d "$AUTOSUGGESTIONS_DIR" ]; then
    print_success "zsh-autosuggestions is already installed"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
    print_success "zsh-autosuggestions installed"
fi

# Install zsh-syntax-highlighting plugin
print_info "Installing zsh-syntax-highlighting plugin..."
SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ -d "$SYNTAX_DIR" ]; then
    print_success "zsh-syntax-highlighting is already installed"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR"
    print_success "zsh-syntax-highlighting installed"
fi

# Install zsh-completions plugin
print_info "Installing zsh-completions plugin..."
COMPLETIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
if [ -d "$COMPLETIONS_DIR" ]; then
    print_success "zsh-completions is already installed"
else
    git clone https://github.com/zsh-users/zsh-completions "$COMPLETIONS_DIR"
    print_success "zsh-completions installed"
fi

# Install z (directory jumping)
print_info "Installing z (directory jumping)..."
if command -v z &> /dev/null; then
    print_success "z is already installed"
else
    brew install z
    print_success "z installed"
fi

# Install fzf (fuzzy finder)
print_info "Installing fzf (fuzzy finder)..."
if command -v fzf &> /dev/null; then
    print_success "fzf is already installed"
else
    brew install fzf
    # Install key bindings and fuzzy completion
    $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish
    print_success "fzf installed with key bindings"
fi

# Install additional useful tools
print_info "Installing additional shell tools..."

# bat - better cat
if ! command -v bat &> /dev/null; then
    brew install bat
    print_success "bat installed (better cat with syntax highlighting)"
else
    print_info "bat is already installed"
fi

# eza - better ls (maintained fork of exa)
if ! command -v eza &> /dev/null; then
    brew install eza
    print_success "eza installed (modern ls replacement)"
else
    print_info "eza is already installed"
fi

# ripgrep - better grep
if ! command -v rg &> /dev/null; then
    brew install ripgrep
    print_success "ripgrep installed (fast grep alternative)"
else
    print_info "ripgrep is already installed"
fi

# htop - better top
if ! command -v htop &> /dev/null; then
    brew install htop
    print_success "htop installed (interactive process viewer)"
else
    print_info "htop is already installed"
fi

# Setup configuration symlinks
print_info "Setting up Zsh configurations..."

# Setup .zshrc symlink
ZSHRC_SOURCE="$SCRIPT_DIR/zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

if [ -e "$ZSHRC_TARGET" ] && [ ! -L "$ZSHRC_TARGET" ]; then
    print_warning "Existing .zshrc found at $ZSHRC_TARGET"
    read -p "Do you want to backup and replace it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$ZSHRC_TARGET" "$ZSHRC_TARGET.backup"
        print_success "Backed up existing .zshrc to $ZSHRC_TARGET.backup"
        ln -sf "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
        print_success ".zshrc symlink created"
    else
        print_info "Keeping existing .zshrc"
    fi
elif [ -L "$ZSHRC_TARGET" ]; then
    ln -sf "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
    print_success ".zshrc symlink updated"
else
    ln -sf "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
    print_success ".zshrc symlink created"
fi

# Setup .p10k.zsh symlink
P10K_SOURCE="$SCRIPT_DIR/p10k.zsh"
P10K_TARGET="$HOME/.p10k.zsh"

if [ -e "$P10K_TARGET" ] && [ ! -L "$P10K_TARGET" ]; then
    print_warning "Existing .p10k.zsh found at $P10K_TARGET"
    read -p "Do you want to backup and replace it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$P10K_TARGET" "$P10K_TARGET.backup"
        print_success "Backed up existing .p10k.zsh to $P10K_TARGET.backup"
        ln -sf "$P10K_SOURCE" "$P10K_TARGET"
        print_success ".p10k.zsh symlink created"
    else
        print_info "Keeping existing .p10k.zsh"
    fi
elif [ -L "$P10K_TARGET" ]; then
    ln -sf "$P10K_SOURCE" "$P10K_TARGET"
    print_success ".p10k.zsh symlink updated"
else
    ln -sf "$P10K_SOURCE" "$P10K_TARGET"
    print_success ".p10k.zsh symlink created"
fi

print_footer "Oh My Zsh and plugins installation completed!"
print_info "Installed components:"
print_info "  - Oh My Zsh framework"
print_info "  - Powerlevel10k theme"
print_info "  - zsh-autosuggestions"
print_info "  - zsh-syntax-highlighting"
print_info "  - zsh-completions"
print_info "  - z (directory jumping)"
print_info "  - fzf (fuzzy finder)"
print_info "  - bat (better cat)"
print_info "  - eza (better ls)"
print_info "  - ripgrep (better grep)"
print_info "  - htop (better top)"
print_info "  - Configuration symlinks (.zshrc and .p10k.zsh)"
print_info ""
print_info "Restart your terminal to apply changes"
