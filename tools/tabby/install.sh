#!/bin/bash

# Tabby Terminal Installation Script
# This script installs Tabby terminal and sets up configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Check if Tabby is already installed
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Check for Tabby.app on macOS
    if [[ -d "/Applications/Tabby.app" ]] || command -v tabby &> /dev/null; then
        echo "Tabby is already installed. Skipping installation..."
    else
        echo "Installing Tabby Terminal..."

        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo "Error: Homebrew is not installed. Please install Homebrew first."
            exit 1
        fi

        # Install Tabby using Homebrew Cask
        echo "Installing Tabby via Homebrew..."
        brew install --cask tabby
        echo "Tabby installation completed!"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Check if tabby command exists on Linux
    if command -v tabby &> /dev/null; then
        echo "Tabby is already installed. Skipping installation..."
    else
        echo "Installing Tabby Terminal..."

        # Check for different package managers
        if command -v apt-get &> /dev/null; then
            # Debian/Ubuntu
            echo "Installing via apt..."
            curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.deb.sh | sudo bash
            sudo apt-get install tabby-terminal
        elif command -v yum &> /dev/null; then
            # RHEL/CentOS/Fedora
            echo "Installing via yum..."
            curl -s https://packagecloud.io/install/repositories/eugeny/tabby/script.rpm.sh | sudo bash
            sudo yum install tabby-terminal
        elif command -v pacman &> /dev/null; then
            # Arch Linux
            echo "Installing via AUR..."
            if command -v yay &> /dev/null; then
                yay -S tabby-bin
            elif command -v paru &> /dev/null; then
                paru -S tabby-bin
            else
                echo "Please install an AUR helper (yay or paru) or install tabby manually from AUR"
                exit 1
            fi
        else
            echo "Unsupported Linux distribution. Please install Tabby manually."
            exit 1
        fi
        echo "Tabby installation completed!"
    fi
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Set up configuration symlinks
echo "Setting up configuration..."

CONFIG_DIR="$HOME/.config/tabby"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Remove existing config if it's not a symlink
if [[ -f "$CONFIG_DIR/config.yaml" && ! -L "$CONFIG_DIR/config.yaml" ]]; then
    echo "Backing up existing config.yaml to config.yaml.backup"
    mv "$CONFIG_DIR/config.yaml" "$CONFIG_DIR/config.yaml.backup"
fi

# Create symlink for config
if [[ -L "$CONFIG_DIR/config.yaml" ]]; then
    echo "Removing existing config.yaml symlink"
    rm "$CONFIG_DIR/config.yaml"
fi

echo "Creating symlink: $CONFIG_DIR/config.yaml -> $SCRIPT_DIR/config.yaml"
ln -s "$SCRIPT_DIR/config.yaml" "$CONFIG_DIR/config.yaml"

echo "Tabby installation and configuration complete!"
echo "Configuration symlinks created successfully!"
echo "You can now launch Tabby terminal."