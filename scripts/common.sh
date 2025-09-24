#!/bin/bash



# Common functions for installation scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_footer() {
    echo -e "\n${GREEN}✓ $1${NC}\n"
}

print_info() {
    echo -e "${BLUE}→ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
}

# Check if Homebrew is installed
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        print_error "Homebrew is not installed"
        print_info "Install it from: https://brew.sh"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Create directory if it doesn't exist
ensure_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_success "Created directory: $1"
    fi
}

# Download file with curl
download_file() {
    local url="$1"
    local dest="$2"
    
    print_info "Downloading from: $url"
    if curl -fsSL "$url" -o "$dest"; then
        print_success "Downloaded to: $dest"
        return 0
    else
        print_error "Failed to download: $url"
        return 1
    fi
}
