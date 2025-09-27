#!/bin/bash

# Font Installation Script
# Installs Nerd Fonts for terminal use, especially for Powerlevel10k

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Terminal Fonts Installation"

# Check if running on macOS
check_macos

FONT_DIR="$HOME/Library/Fonts"
ensure_dir "$FONT_DIR"

# Function to download font from URL
download_font() {
    local url="$1"
    local filename="$2"
    local dest="$FONT_DIR/$filename"
    
    if [ -f "$dest" ]; then
        print_info "$filename already exists"
        return 0
    fi
    
    print_info "Downloading $filename..."
    if curl -L -o "$dest" "$url"; then
        print_success "$filename downloaded"
    else
        print_error "Failed to download $filename"
        return 1
    fi
}

# Install MesloLGS NF (Powerlevel10k recommended font)
print_info "Installing MesloLGS NF (Powerlevel10k recommended)..."
p10k_fonts=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
)

for font in "${p10k_fonts[@]}"; do
    url_font="${font// /%20}"
    download_font "https://github.com/romkatv/powerlevel10k-media/raw/master/$url_font" "$font"
done

# Install Nerd Fonts from GitHub releases
print_info "Installing additional Nerd Fonts..."

# Function to install a Nerd Font from GitHub
install_nerd_font() {
    local font_name="$1"
    local zip_name="$2"
    local font_display_name="$3"
    
    print_info "Installing $font_display_name..."
    
    # Check if already installed
    if fc-list | grep -q "$font_name"; then
        print_success "$font_display_name is already installed"
        return 0
    fi
    
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Download from Nerd Fonts GitHub releases
    if curl -L -o "$zip_name.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$zip_name.zip"; then
        # Extract and install
        unzip -q "$zip_name.zip" || true
        
        # Copy font files
        find . -name "*.ttf" -o -name "*.otf" | while read -r font_file; do
            cp "$font_file" "$FONT_DIR/" 2>/dev/null || true
        done
        
        print_success "$font_display_name installed"
    else
        print_warning "Failed to download $font_display_name"
    fi
    
    # Clean up
    cd - > /dev/null
    rm -rf "$TEMP_DIR"
}

# Install popular Nerd Fonts
install_nerd_font "SauceCodePro" "SourceCodePro" "SauceCodePro Nerd Font"
install_nerd_font "Hack Nerd Font" "Hack" "Hack Nerd Font"
install_nerd_font "JetBrainsMono Nerd Font" "JetBrainsMono" "JetBrains Mono Nerd Font"
install_nerd_font "FiraCode Nerd Font" "FiraCode" "Fira Code Nerd Font"

# Refresh font cache (macOS automatically does this, but we can trigger it)
print_info "Refreshing font cache..."
if command -v fc-cache &> /dev/null; then
    fc-cache -f
    print_success "Font cache refreshed"
fi

# List installed Nerd Fonts
print_info "Checking installed Nerd Fonts..."
echo ""
echo "Installed Nerd Fonts:"
fc-list | grep -i "nerd font" | cut -d: -f2 | sort -u | sed 's/^ /  - /'

print_footer "Font installation completed!"
print_info ""
print_info "Installed fonts:"
print_info "  - MesloLGS NF (Powerlevel10k recommended)"
print_info "  - SauceCodePro Nerd Font (Source Code Pro with icons)"
print_info "  - Hack Nerd Font"
print_info "  - JetBrains Mono Nerd Font"
print_info "  - Fira Code Nerd Font"
print_info ""
print_info "To use these fonts:"
print_info "1. Update your terminal emulator's font settings"
print_info "2. For Alacritty: Edit ~/.config/alacritty/alacritty.toml"
print_info "3. For iTerm2: Preferences → Profiles → Text → Font"
print_info "4. For Terminal.app: Preferences → Profiles → Text → Font"
print_info ""
print_info "Recommended fonts for Powerlevel10k:"
print_info "  - MesloLGS NF (best compatibility)"
print_info "  - Any Nerd Font variant for icon support"
