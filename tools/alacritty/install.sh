#!/bin/bash

# Alacritty Terminal Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Alacritty Terminal Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install Alacritty
print_info "Installing Alacritty terminal emulator..."
if [ -d "/Applications/Alacritty.app" ]; then
    print_success "Alacritty is already installed"
else
    brew install --cask alacritty
    print_success "Alacritty installed successfully"
fi

# Install Nerd Font version of Source Code Pro (SauceCodePro)
print_info "Installing SauceCodePro Nerd Font (for Powerlevel10k icons)..."
if fc-list | grep -q "SauceCodePro" || ls ~/Library/Fonts/SauceCodePro*.ttf 2>/dev/null | grep -q .; then
    print_success "SauceCodePro Nerd Font is already installed"
else
    print_info "Downloading SauceCodePro Nerd Font..."
    FONT_DIR="$HOME/Library/Fonts"
    ensure_dir "$FONT_DIR"
    
    # Download the Nerd Font version
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download from Nerd Fonts GitHub releases
    curl -L -o SauceCodePro.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/SourceCodePro.zip"
    
    # Extract and install
    unzip -q SauceCodePro.zip
    
    # Install the font files
    cp *.ttf "$FONT_DIR/" 2>/dev/null || cp *.otf "$FONT_DIR/" 2>/dev/null
    
    # Clean up
    cd - > /dev/null
    rm -rf "$TEMP_DIR"
    
    print_success "SauceCodePro Nerd Font installed to $FONT_DIR"
    print_info "You may need to restart Alacritty for the font to be available"
fi

# Also install the recommended Meslo Nerd Font for P10k
print_info "Installing MesloLGS NF (recommended font for Powerlevel10k)..."
if fc-list | grep -q "MesloLGS NF" || ls ~/Library/Fonts/MesloLGS*.ttf 2>/dev/null | grep -q .; then
    print_success "MesloLGS NF is already installed"
else
    print_info "Downloading MesloLGS NF fonts..."
    FONT_DIR="$HOME/Library/Fonts"
    
    # Download all four variants of MesloLGS NF
    for variant in "Regular" "Bold" "Italic" "Bold%20Italic"; do
        font_file="MesloLGS%20NF%20${variant}.ttf"
        curl -L -o "$FONT_DIR/${font_file// /%20}" \
            "https://github.com/romkatv/powerlevel10k-media/raw/master/${font_file}"
    done
    
    print_success "MesloLGS NF fonts installed (recommended for Powerlevel10k)"
fi

# Create Alacritty config directory
ALACRITTY_CONFIG_DIR="$HOME/.config/alacritty"
ensure_dir "$ALACRITTY_CONFIG_DIR"

# Setup configuration symlink
print_info "Setting up Alacritty configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/alacritty.toml"
CONFIG_TARGET="$ALACRITTY_CONFIG_DIR/alacritty.toml"

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

print_footer "Alacritty installation completed!"
print_info "Installed components:"
print_info "  - Alacritty terminal emulator"
print_info "  - SauceCodePro Nerd Font (Source Code Pro with icons)"
print_info "  - MesloLGS NF (recommended font for Powerlevel10k)"
print_info "  - Configuration symlink"
print_info ""
print_info "Next steps:"
print_info "1. Launch Alacritty from Applications or Spotlight"
print_info "2. The Doom One theme will be applied automatically"
print_info "3. Powerlevel10k icons should display correctly"
print_info ""
print_info "Font options in config:"
print_info "  - Current: MesloLGS NF (best for P10k)"
print_info "  - Alternative: SauceCodePro Nerd Font"
print_info ""
print_info "Useful tips:"
print_info "  - Use Cmd+, to reload configuration"
print_info "  - Run 'p10k configure' if you still see broken icons"
print_info "  - Check ~/.config/alacritty/alacritty.toml for customization"
