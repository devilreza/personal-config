#!/bin/bash

# Personal macOS Configuration Setup Script
# This script helps set up the development environment

set -e

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔════════════════════════════════════════════════════╗"
echo "║     Personal macOS Development Environment         ║"
echo "║                    Setup Script                    ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""
echo "Configuration directory: $CONFIG_DIR"
echo ""

# Function to display tool information
show_tools() {
    echo "Available tools:"
    echo ""
    for tool_dir in "$CONFIG_DIR/tools"/*/; do
        if [ -f "$tool_dir/install.sh" ]; then
            tool_name=$(basename "$tool_dir")
            printf "  %-20s" "$tool_name"
            
            # Show brief description based on tool
            case "$tool_name" in
                "alacritty") echo "- GPU-accelerated terminal emulator" ;;
                "docker") echo "- Container platform" ;;
                "docker-services") echo "- Dockerized databases (Redis, PostgreSQL, MySQL)" ;;
                "fonts") echo "- Nerd Fonts for terminal icons and symbols" ;;
                "git-tools") echo "- Git enhancements and utilities" ;;
                "golang") echo "- Go programming language and tools" ;;
                "kubernetes-tools") echo "- Kubernetes CLI tools" ;;
                "nodejs") echo "- Node.js with NVM" ;;
                "ohmyzsh") echo "- Zsh framework with plugins" ;;
                "python") echo "- Python with pyenv" ;;
                "tmux") echo "- Terminal multiplexer" ;;
                "vim") echo "- Text editor with plugins" ;;
                "dev-tools") echo "- Development tools (protoc, IDEs, etc.)" ;;
                *) echo "" ;;
            esac
        fi
    done
}

# Main menu
echo "What would you like to do?"
echo ""
echo "1) Install all tools (interactive)"
echo "2) Install all tools (automatic)"
echo "3) Install specific tools"
echo "4) Show available tools"
echo "5) Exit"
echo ""
read -p "Enter your choice [1-5]: " choice

case $choice in
    1)
        echo ""
        echo "Starting interactive installation..."
        bash "$CONFIG_DIR/scripts/install-all.sh"
        ;;
    2)
        echo ""
        echo "Starting automatic installation..."
        bash "$CONFIG_DIR/scripts/install-all.sh" --all
        ;;
    3)
        echo ""
        show_tools
        echo ""
        read -p "Enter tool name to install (or 'cancel' to exit): " tool_name
        if [ "$tool_name" != "cancel" ] && [ -f "$CONFIG_DIR/tools/$tool_name/install.sh" ]; then
            bash "$CONFIG_DIR/tools/$tool_name/install.sh"
        else
            echo "Tool not found or cancelled."
        fi
        ;;
    4)
        echo ""
        show_tools
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "Setup completed!"
echo ""
echo "Note: Each tool's installer handles its own configuration symlinks."
echo "You may need to restart your terminal for changes to take effect."