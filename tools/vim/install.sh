#!/bin/bash

# Vim Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Vim Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install vim
print_info "Installing Vim..."
if command -v vim &> /dev/null; then
    print_success "Vim is already installed: $(vim --version | head -n1)"
else
    brew install vim
    print_success "Vim installed successfully"
fi

# Install MacVim for GUI support (optional)
print_info "Installing MacVim (GUI version)..."
if command -v mvim &> /dev/null; then
    print_success "MacVim is already installed"
else
    brew install macvim
    print_success "MacVim installed successfully"
fi

# Install Vim runtime (Ultimate vimrc)
print_info "Installing Ultimate vimrc..."
VIM_RUNTIME_DIR="$HOME/.vim_runtime"
if [ -d "$VIM_RUNTIME_DIR" ]; then
    print_success "Ultimate vimrc is already installed"
else
    git clone --depth=1 https://github.com/amix/vimrc.git "$VIM_RUNTIME_DIR"
    sh "$VIM_RUNTIME_DIR/install_awesome_vimrc.sh"
    print_success "Ultimate vimrc installed"
fi

# Install additional vim plugins dependencies
print_info "Installing vim plugin dependencies..."

# Install ctags for code navigation
if ! command -v ctags &> /dev/null; then
    brew install ctags
    print_success "ctags installed"
else
    print_info "ctags is already installed"
fi

# Install universal-ctags (modern ctags)
if ! command -v universal-ctags &> /dev/null; then
    brew install universal-ctags
    print_success "universal-ctags installed"
else
    print_info "universal-ctags is already installed"
fi

# Install the_silver_searcher (ag) for fast searching
if ! command -v ag &> /dev/null; then
    brew install the_silver_searcher
    print_success "the_silver_searcher (ag) installed"
else
    print_info "the_silver_searcher is already installed"
fi

# Install ripgrep (rg) for even faster searching
if ! command -v rg &> /dev/null; then
    brew install ripgrep
    print_success "ripgrep (rg) installed"
else
    print_info "ripgrep is already installed"
fi

# Install fd (find alternative)
if ! command -v fd &> /dev/null; then
    brew install fd
    print_success "fd installed"
else
    print_info "fd is already installed"
fi

# Install fzf (fuzzy finder)
if ! command -v fzf &> /dev/null; then
    brew install fzf
    print_success "fzf installed"
else
    print_info "fzf is already installed"
fi

# Install bat (better cat)
if ! command -v bat &> /dev/null; then
    brew install bat
    print_success "bat installed"
else
    print_info "bat is already installed"
fi

# Install exa (better ls)
if ! command -v eza &> /dev/null; then
    brew install eza
    print_success "eza installed"
else
    print_info "eza is already installed"
fi

# Install delta (better git diff)
if ! command -v delta &> /dev/null; then
    brew install git-delta
    print_success "delta installed"
else
    print_info "delta is already installed"
fi

# Install tree (directory tree)
if ! command -v tree &> /dev/null; then
    brew install tree
    print_success "tree installed"
else
    print_info "tree is already installed"
fi

# Install jq (JSON processor)
if ! command -v jq &> /dev/null; then
    brew install jq
    print_success "jq installed"
else
    print_info "jq is already installed"
fi

# Install yq (YAML processor)
if ! command -v yq &> /dev/null; then
    brew install yq
    print_success "yq installed"
else
    print_info "yq is already installed"
fi

# Install VS Code-like development tools
print_info "Installing VS Code-like development tools..."

# Install prettier for JavaScript/TypeScript formatting
if ! command -v prettier &> /dev/null; then
    npm install -g prettier
    print_success "prettier installed"
else
    print_info "prettier is already installed"
fi

# Install autopep8 for Python formatting
if ! command -v autopep8 &> /dev/null; then
    pip3 install autopep8
    print_success "autopep8 installed"
else
    print_info "autopep8 is already installed"
fi

# Install black for Python formatting (alternative)
if ! command -v black &> /dev/null; then
    pip3 install black
    print_success "black installed"
else
    print_info "black is already installed"
fi

# Install flake8 for Python linting
if ! command -v flake8 &> /dev/null; then
    pip3 install flake8
    print_success "flake8 installed"
else
    print_info "flake8 is already installed"
fi

# Install eslint for JavaScript linting
if ! command -v eslint &> /dev/null; then
    npm install -g eslint
    print_success "eslint installed"
else
    print_info "eslint is already installed"
fi

# Install Go development tools
print_info "Installing Go development tools..."

# Install Go tools for development
if command -v go &> /dev/null; then
    print_info "Installing Go development tools..."
    
    # Install gopls (Go Language Server)
    go install golang.org/x/tools/gopls@latest
    print_success "gopls installed"
    
    # Install goimports (auto import management)
    go install golang.org/x/tools/cmd/goimports@latest
    print_success "goimports installed"
    
    # Install godef (Go definition finder)
    go install github.com/rogpeppe/godef@latest
    print_success "godef installed"
    
    # Install guru (Go code analysis)
    go install golang.org/x/tools/cmd/guru@latest
    print_success "guru installed"
    
    # Install gorename (Go refactoring)
    go install golang.org/x/tools/cmd/gorename@latest
    print_success "gorename installed"
    
    # Install gotests (Go test generation)
    go install github.com/cweill/gotests/gotests@latest
    print_success "gotests installed"
    
    # Install gomodifytags (Go struct tag modification)
    go install github.com/fatih/gomodifytags@latest
    print_success "gomodifytags installed"
    
    # Install impl (Go interface implementation)
    go install github.com/josharian/impl@latest
    print_success "impl installed"
    
    # Install goplay (Go playground)
    go install github.com/haya14busa/goplay/cmd/goplay@latest
    print_success "goplay installed"
    
    # Install dlv (Delve debugger)
    go install github.com/go-delve/delve/cmd/dlv@latest
    print_success "dlv (Delve debugger) installed"
    
    # Install air (live reload for Go)
    go install github.com/cosmtrek/air@latest
    print_success "air (live reload) installed"
    
    # Install gow (file watcher for Go)
    go install github.com/mitranim/gow@latest
    print_success "gow (file watcher) installed"
    
    # Install richgo (colorized go test output)
    go install github.com/kyoh86/richgo@latest
    print_success "richgo installed"
    
    # Install gocov (Go coverage tool)
    go install github.com/axw/gocov/gocov@latest
    print_success "gocov installed"
    
    # Install gocovmerge (merge coverage profiles)
    go install github.com/wadey/gocovmerge@latest
    print_success "gocovmerge installed"
    
    # Install go-carpet (Go test coverage in terminal)
    go install github.com/msoap/go-carpet@latest
    print_success "go-carpet installed"
    
    # Install gocyclo (Go cyclomatic complexity)
    go install github.com/fzipp/gocyclo/cmd/gocyclo@latest
    print_success "gocyclo installed"
    
    # Install ineffassign (Go ineffectual assignments)
    go install github.com/gordonklaus/ineffassign@latest
    print_success "ineffassign installed"
    
    # Install misspell (Go spell checker)
    go install github.com/client9/misspell/cmd/misspell@latest
    print_success "misspell installed"
    
    # Install gosec (Go security checker)
    go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest
    print_success "gosec installed"
    
    # Install staticcheck (Go static analysis)
    go install honnef.co/go/tools/cmd/staticcheck@latest
    print_success "staticcheck installed"
    
    # Install gomock (Go mock generation)
    go install github.com/golang/mock/mockgen@latest
    print_success "gomock installed"
    
    # Install gofumpt (stricter gofmt)
    go install mvdan.cc/gofumpt@latest
    print_success "gofumpt installed"
    
    # Install golangci-lint (Go linter aggregator)
    if ! command -v golangci-lint &> /dev/null; then
        curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.54.2
        print_success "golangci-lint installed"
    else
        print_info "golangci-lint is already installed"
    fi
    
    print_success "All Go development tools installed successfully"
else
    print_warning "Go is not installed. Please install Go first to get Go development tools."
fi

# Create vim directories
ensure_dir "$HOME/.vim"
ensure_dir "$HOME/.vim/undodir"
ensure_dir "$HOME/.vim/backup"
ensure_dir "$HOME/.vim/swap"

# Setup configuration symlink
print_info "Setting up vim configuration..."
CONFIG_SOURCE="$SCRIPT_DIR/vimrc"
CONFIG_TARGET="$HOME/.vimrc"

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

# Create additional vim configuration directories
ensure_dir "$HOME/.vim_runtime"
ensure_dir "$HOME/.vim_runtime/my_configs"
ensure_dir "$HOME/.vim_runtime/custom_configs"

# Create a sample custom configuration file
CUSTOM_CONFIG_FILE="$HOME/.vim_runtime/custom_configs.vim"
if [ ! -f "$CUSTOM_CONFIG_FILE" ]; then
    cat > "$CUSTOM_CONFIG_FILE" << 'EOF'
" Custom Vim Configuration
" Add your personal customizations here

" Example: Custom key mappings
" nnoremap <leader>xx :!echo "Hello from custom config!"<CR>

" Example: Custom functions
" function! MyCustomFunction()
"     echo "This is a custom function"
" endfunction

" Example: Custom autocmds
" autocmd BufWritePost *.py call MyCustomFunction()
EOF
    print_success "Created sample custom configuration file"
fi

print_footer "Vim installation completed!"
print_info "Installed components:"
print_info "  - vim (Vi IMproved)"
print_info "  - MacVim (GUI version)"
print_info "  - Ultimate vimrc configuration"
print_info "  - Enhanced vimrc with modern features"
print_info "  - ctags & universal-ctags (code navigation)"
print_info "  - the_silver_searcher (ag) & ripgrep (rg) (fast searching)"
print_info "  - fd (find alternative)"
print_info "  - fzf (fuzzy finder)"
print_info "  - bat (better cat)"
print_info "  - exa (better ls)"
print_info "  - delta (better git diff)"
print_info "  - tree (directory tree)"
print_info "  - jq (JSON processor)"
print_info "  - yq (YAML processor)"
print_info ""
print_info "Configuration features:"
print_info "  - VS Code-like interface and key mappings"
print_info "  - Modern vim settings and performance optimizations"
print_info "  - Enhanced key mappings and shortcuts"
print_info "  - Language-specific configurations (Python, JS/TS, Go, etc.)"
print_info "  - Custom functions for common tasks"
print_info "  - Plugin configurations for better development experience"
print_info "  - Code formatting and linting tools"
print_info "  - Enhanced status bar and tab line"
print_info ""
print_info "Next steps:"
print_info "1. Launch vim and explore the enhanced configuration"
print_info "2. Check :PluginList for available plugins"
print_info "3. Use :PluginInstall to install additional plugins"
print_info "4. Customize ~/.vim_runtime/custom_configs.vim for personal preferences"
print_info "5. Try the new key mappings: <leader>w, <leader>j, <leader>nn, etc."
