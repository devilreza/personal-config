#!/bin/bash

# Development Tools Installation Script
# Installs protoc, DBeaver, IDEs (Cursor, Zed), and doctl

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Development Tools Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install protoc (Protocol Buffers compiler)
print_info "Installing protoc (Protocol Buffers compiler)..."
if command -v protoc &> /dev/null; then
    print_success "protoc is already installed: $(protoc --version)"
else
    brew install protobuf
    print_success "protoc installed successfully"
fi

# Install protoc-gen-go for Go support
print_info "Installing protoc-gen-go..."
if command -v protoc-gen-go &> /dev/null; then
    print_success "protoc-gen-go is already installed"
else
    if command -v go &> /dev/null; then
        go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
        go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
        print_success "protoc-gen-go and protoc-gen-go-grpc installed"
    else
        print_warning "Go is not installed. Skipping protoc-gen-go installation"
        print_info "Run install-golang.sh first to install Go"
    fi
fi

# Install grpcurl for testing gRPC services
print_info "Installing grpcurl..."
if command -v grpcurl &> /dev/null; then
    print_success "grpcurl is already installed"
else
    brew install grpcurl
    print_success "grpcurl installed successfully"
fi

# Install buf for Protocol Buffers linting and breaking change detection
print_info "Installing buf (Protocol Buffers build tool)..."
if command -v buf &> /dev/null; then
    print_success "buf is already installed: $(buf --version)"
else
    brew install bufbuild/buf/buf
    print_success "buf installed successfully"
fi

# Install DBeaver (Database management tool)
print_info "Installing DBeaver Community Edition..."
if [ -d "/Applications/DBeaver.app" ]; then
    print_success "DBeaver is already installed"
else
    brew install --cask dbeaver-community
    print_success "DBeaver installed successfully"
fi

# Install Cursor AI IDE
print_info "Installing Cursor AI IDE..."
if [ -d "/Applications/Cursor.app" ]; then
    print_success "Cursor is already installed"
else
    brew install --cask cursor
    print_success "Cursor AI IDE installed successfully"
fi

# Install Zed IDE
print_info "Installing Zed IDE..."
if [ -d "/Applications/Zed.app" ]; then
    print_success "Zed is already installed"
else
    brew install --cask zed
    print_success "Zed IDE installed successfully"
fi

# Install doctl (DigitalOcean CLI)
print_info "Installing doctl (DigitalOcean CLI)..."
if command -v doctl &> /dev/null; then
    print_success "doctl is already installed: $(doctl version)"
else
    brew install doctl
    print_success "doctl installed successfully"
fi

# Install additional development tools
print_info "Installing additional development tools..."

# Install jq for JSON processing
if ! command -v jq &> /dev/null; then
    brew install jq
    print_success "jq installed (JSON processor)"
else
    print_info "jq is already installed"
fi

# Install yq for YAML processing
if ! command -v yq &> /dev/null; then
    brew install yq
    print_success "yq installed (YAML processor)"
else
    print_info "yq is already installed"
fi

# Install httpie for HTTP testing
if ! command -v http &> /dev/null; then
    brew install httpie
    print_success "httpie installed (HTTP client)"
else
    print_info "httpie is already installed"
fi

# Install watch command
if ! command -v watch &> /dev/null; then
    brew install watch
    print_success "watch installed"
else
    print_info "watch is already installed"
fi

# Install tree for directory visualization
if ! command -v tree &> /dev/null; then
    brew install tree
    print_success "tree installed"
else
    print_info "tree is already installed"
fi

# Install VS Code (optional, but useful)
print_info "Checking Visual Studio Code..."
if [ -d "/Applications/Visual Studio Code.app" ]; then
    print_info "VS Code is already installed"
else
    print_info "VS Code is not installed. Install it with:"
    print_info "  brew install --cask visual-studio-code"
fi

# Set up shell completion for doctl
print_info "Setting up doctl completion..."
if ! grep -q 'doctl completion' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# doctl completion
if command -v doctl &> /dev/null; then
    source <(doctl completion zsh)
fi
EOF
    print_success "doctl completion added to ~/.zshrc"
else
    print_info "doctl completion already configured"
fi

print_footer "Development tools installation completed!"
print_info "Installed tools:"
print_info "  - protoc (Protocol Buffers compiler)"
print_info "  - protoc-gen-go (Go protobuf plugin)"
print_info "  - grpcurl (gRPC testing tool)"
print_info "  - buf (Protocol Buffers build tool)"
print_info "  - DBeaver (Database management)"
print_info "  - Cursor AI (AI-powered IDE)"
print_info "  - Zed (Fast, collaborative IDE)"
print_info "  - doctl (DigitalOcean CLI)"
print_info "  - jq (JSON processor)"
print_info "  - yq (YAML processor)"
print_info "  - httpie (HTTP client)"
print_info "  - watch (execute commands periodically)"
print_info "  - tree (directory visualization)"
print_info ""
print_info "Next steps:"
print_info "1. Launch DBeaver and configure database connections"
print_info "2. Launch Cursor or Zed and configure as needed"
print_info "3. Run 'doctl auth init' to authenticate with DigitalOcean"
print_info ""
print_info "Useful commands:"
print_info "  protoc --go_out=. file.proto    # Compile protobuf to Go"
print_info "  grpcurl -plaintext localhost:50051 list   # List gRPC services"
print_info "  buf lint                        # Lint protobuf files"
print_info "  buf breaking --against '.git#branch=main'  # Check breaking changes"
print_info "  buf generate                    # Generate code from proto files"
print_info "  doctl account get               # Check DigitalOcean account"
print_info "  http GET httpbin.org/get        # Make HTTP requests"
print_info "  jq '.' file.json                # Pretty print JSON"
print_info "  yq '.' file.yaml                # Process YAML files"
