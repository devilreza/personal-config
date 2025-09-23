#!/bin/bash

# Python Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Python Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install pyenv for Python version management
print_info "Installing pyenv (Python version manager)..."
if command -v pyenv &> /dev/null; then
    print_success "pyenv is already installed: $(pyenv --version)"
else
    brew install pyenv
    print_success "pyenv installed successfully"
fi

# Install pyenv-virtualenv for virtual environment management
print_info "Installing pyenv-virtualenv..."
if brew list pyenv-virtualenv &>/dev/null; then
    print_success "pyenv-virtualenv is already installed"
else
    brew install pyenv-virtualenv
    print_success "pyenv-virtualenv installed successfully"
fi

# Add pyenv to shell configuration
print_info "Configuring pyenv in shell..."
if ! grep -q 'pyenv init' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
EOF
    print_success "pyenv configuration added to ~/.zshrc"
else
    print_info "pyenv configuration already exists in ~/.zshrc"
fi

# Initialize pyenv for current session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Install Python build dependencies
print_info "Installing Python build dependencies..."
brew install openssl readline sqlite3 xz zlib tcl-tk

# Install latest stable Python 3
print_info "Installing latest stable Python 3..."
LATEST_PYTHON=$(pyenv install --list | grep -E '^\s*3\.[0-9]+\.[0-9]+$' | tail -1 | xargs)
if pyenv versions | grep -q "$LATEST_PYTHON"; then
    print_success "Python $LATEST_PYTHON is already installed"
else
    print_info "Installing Python $LATEST_PYTHON..."
    pyenv install "$LATEST_PYTHON"
    print_success "Python $LATEST_PYTHON installed successfully"
fi

# Set as global Python version
pyenv global "$LATEST_PYTHON"
print_success "Python $LATEST_PYTHON set as global version"

# Install pipx for installing Python applications
print_info "Installing pipx..."
if command -v pipx &> /dev/null; then
    print_success "pipx is already installed"
else
    brew install pipx
    pipx ensurepath
    print_success "pipx installed successfully"
fi

# Install useful Python tools
print_info "Installing Python development tools..."

# Update pip
python -m pip install --upgrade pip

# Install essential Python packages
pip install --upgrade \
    setuptools \
    wheel \
    virtualenv \
    ipython \
    black \
    flake8 \
    pylint \
    mypy \
    pytest \
    requests \
    numpy \
    pandas

print_success "Python development tools installed"

# Install poetry for dependency management
print_info "Installing Poetry..."
if command -v poetry &> /dev/null; then
    print_success "Poetry is already installed: $(poetry --version)"
else
    curl -sSL https://install.python-poetry.org | python3 -
    print_success "Poetry installed successfully"
fi

# Add Poetry to PATH if not already added
if ! grep -q 'poetry/bin' ~/.zshrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# Install additional Python tools with pipx
print_info "Installing additional Python applications..."

# httpie - Better curl
if ! command -v http &> /dev/null; then
    pipx install httpie
    print_success "httpie installed"
fi

# glances - System monitoring
if ! command -v glances &> /dev/null; then
    pipx install glances
    print_success "glances installed"
fi

# tldr - Simplified man pages
if ! command -v tldr &> /dev/null; then
    pipx install tldr
    print_success "tldr installed"
fi

print_footer "Python installation completed!"
print_info "Installed components:"
print_info "  - pyenv (Python version manager)"
print_info "  - Python $LATEST_PYTHON"
print_info "  - pipx (Python application installer)"
print_info "  - Poetry (dependency management)"
print_info "  - Development tools: black, flake8, pylint, mypy, pytest"
print_info "  - Data science basics: numpy, pandas"
print_info "  - CLI tools: httpie, glances, tldr"
print_info ""
print_info "Useful commands:"
print_info "  pyenv install --list       # List available Python versions"
print_info "  pyenv install 3.x.x       # Install specific Python version"
print_info "  pyenv global 3.x.x        # Set global Python version"
print_info "  pyenv local 3.x.x         # Set project-specific Python version"
print_info "  poetry new project-name    # Create new Python project"
print_info "  pipx install <package>     # Install Python CLI applications"
print_info ""
print_info "Restart your terminal or run: source ~/.zshrc"
