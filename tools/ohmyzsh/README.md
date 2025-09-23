# Oh My Zsh Configuration

Zsh configuration with Oh My Zsh framework, Powerlevel10k theme, and productivity plugins.

## Features

- **Framework**: Oh My Zsh
- **Theme**: Powerlevel10k with custom prompt
- **Plugins**: git, zsh-autosuggestions, zsh-syntax-highlighting, kubectl, docker, and more
- **Shell Tools**: fzf, z, bat, exa, ripgrep, htop
- **Custom Aliases**: Extensive aliases for common commands

## Installation

```bash
./install.sh
```

This will:
1. Install Oh My Zsh framework
2. Install Powerlevel10k theme
3. Install zsh plugins (autosuggestions, syntax highlighting, completions)
4. Install shell enhancement tools (fzf, z, bat, exa, ripgrep, htop)
5. Configure shell completions

## Configuration Files

- `zshrc` - Main Zsh configuration with aliases and environment setup
- `p10k.zsh` - Powerlevel10k theme configuration

## Key Features

### Aliases

#### Navigation
- `ll` - Detailed list with hidden files
- `la` - List all files
- `..` - Go up one directory
- `...` - Go up two directories
- `....` - Go up three directories

#### Git
- `g` - git
- `gst` - git status
- `gco` - git checkout
- `gcm` - git commit -m
- `gaa` - git add --all
- `gp` - git push
- `gl` - git pull

#### Docker
- `d` - docker
- `dc` - docker-compose
- `dps` - docker ps
- `di` - docker images

#### Kubernetes
- `k` - kubectl
- `kgp` - kubectl get pods
- `kgs` - kubectl get svc
- `kgd` - kubectl get deployment

### Plugins

- **git** - Git aliases and functions
- **zsh-autosuggestions** - Fish-like autosuggestions
- **zsh-syntax-highlighting** - Fish-like syntax highlighting
- **kubectl** - Kubernetes completion and aliases
- **docker** - Docker completion and aliases
- **golang** - Go development support
- **nvm** - Node Version Manager integration

### Shell Tools

- **fzf** - Fuzzy finder for history and files
- **z** - Jump to frequently used directories
- **bat** - Better cat with syntax highlighting
- **eza** - Modern ls replacement (maintained fork of exa)
- **ripgrep** - Fast grep alternative
- **htop** - Interactive process viewer

## Customization

### Adding Aliases
Edit `zshrc` and add your aliases in the appropriate section.

### Changing Theme
Run `p10k configure` to reconfigure Powerlevel10k theme.

### Adding Plugins
Edit the `plugins` array in `zshrc` to add more Oh My Zsh plugins.

## Tips

1. Use `Tab` for autocompletion
2. Use `Ctrl+R` for fuzzy history search (fzf)
3. Use `z <partial-path>` to jump to directories
4. Use `bat` instead of `cat` for syntax-highlighted file viewing
5. Use `eza` instead of `ls` for better directory listings
