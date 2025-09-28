# Personal macOS Configuration

This repository contains my personal configuration files and installation scripts for a complete macOS development environment.

## Repository Structure

```
.
├── setup.sh                 # Interactive setup menu
├── scripts/
│   ├── common.sh           # Shared functions for installers
│   └── install-all.sh      # Master installer script
└── tools/                  # Individual tool configurations and installers
    ├── alacritty/         # Terminal emulator
    ├── dev-tools/         # Development tools (protoc, IDEs, etc.)
    ├── docker/            # Docker and Docker Desktop
    ├── docker-services/   # Dockerized databases
    ├── fonts/             # Nerd Fonts for terminals
    ├── git-tools/         # Git enhancements
    ├── golang/            # Go development environment
    ├── kubernetes-tools/  # Kubernetes CLI tools
    ├── nodejs/            # Node.js with NVM
    ├── ohmyzsh/           # Zsh and Oh My Zsh
    ├── python/            # Python with pyenv
    ├── tmux/              # Terminal multiplexer
    └── vim/               # Vim editor
```

Each tool directory contains:
- `install.sh` - Installation script that handles both installation and configuration
- `README.md` - Documentation and usage
- Configuration files (if applicable)

**Note**: Each tool's installer automatically creates the necessary symlinks for its configuration files.

## Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/devilreza/personal-config.git
cd personal-config
```

### 2. Run Setup Script
Interactive menu for installation options:
```bash
./setup.sh
```

### 3. Installation Options

#### Option A: Install Everything
```bash
./scripts/install-all.sh --all
```

#### Option B: Interactive Installation
```bash
./scripts/install-all.sh
```

#### Option C: Install Individual Tools
```bash
cd tools/<tool-name>
./install.sh
```

## Included Tools

### Terminal & Shell
- **Alacritty** - GPU-accelerated terminal with Doom One theme
- **Oh My Zsh** - Zsh framework with Powerlevel10k theme
- **tmux** - Terminal multiplexer with custom key bindings
- **vim** - Text editor with Ultimate vimrc configuration
- **Fonts** - Nerd Fonts for terminal icons and Powerline symbols

### Programming Languages
- **Go** - With golangci-lint and mockery
- **Node.js** - Via NVM with yarn and pnpm
- **Python** - Via pyenv with Poetry and development tools

### Container & Cloud
- **Docker** - Docker Desktop with Docker Compose
- **Kubernetes** - kubectl, OpenShift CLI, k9s, helm
- **Docker Services** - Pre-configured Redis, PostgreSQL, MySQL

### Development Tools
- **Git Tools** - delta, tig, lazygit, commitizen, standard-version
- **IDEs** - Cursor AI, Zed
- **Database** - DBeaver for database management
- **Others** - protoc, buf, doctl, jq, yq, httpie

## Configuration Files

Each tool's installer creates symlinks for its configuration files:
- `~/.tmux.conf` → `tools/tmux/tmux.conf`
- `~/.zshrc` → `tools/ohmyzsh/zshrc`
- `~/.p10k.zsh` → `tools/ohmyzsh/p10k.zsh`
- `~/.vimrc` → `tools/vim/vimrc`
- `~/.config/alacritty/alacritty.toml` → `tools/alacritty/alacritty.toml`

The installers will prompt before replacing existing configurations and create backups if needed.

## Post-Installation

1. **Restart Terminal** or run `source ~/.zshrc`

2. **Configure Git**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

3. **Launch Applications**:
   - Docker Desktop
   - Alacritty terminal
   - Your preferred IDE

4. **Authenticate CLIs**:
   ```bash
   gh auth login          # GitHub CLI
   doctl auth init        # DigitalOcean
   ```

5. **Start Docker Services** (if installed):
   ```bash
   cd ~/docker-services
   ./start.sh
   ```

## Customization

Each tool can be customized by editing files in its directory:
- Configuration files for tool-specific settings
- `install.sh` scripts for installation options
- README files for documentation

## Requirements

- macOS (scripts are designed for macOS)
- Command Line Tools for Xcode
- Admin privileges for some installations

## Security Note

Some configuration files may contain sensitive information. Review and update:
- API tokens in shell aliases
- Database passwords in docker-compose files
- Any other credentials before committing

## Contributing

Feel free to fork and customize for your own use. Pull requests for improvements are welcome!

## License

MIT License - See LICENSE file for details
