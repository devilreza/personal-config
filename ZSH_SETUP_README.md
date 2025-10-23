# Oh My Zsh + Monokai Theme Setup Guide

This guide will help you replicate your Zsh configuration with the Monokai Pro theme on a new macOS laptop.

## Quick Start

On your new macOS laptop, run:

```bash
bash setup-zsh-config.sh
```

Then restart your terminal or run:
```bash
source ~/.zshrc
```

## What This Script Does

### 1. Installs Essential Software
- **Homebrew**: macOS package manager
- **Oh My Zsh**: Zsh configuration framework
- **NVM**: Node Version Manager
- **pyenv**: Python version manager
- **Go**: Go programming language
- **kubectl**: Kubernetes CLI
- **kubectx/kubens**: Context/namespace switcher for kubectl
- **Helm**: Kubernetes package manager
- **lazygit**: Terminal UI for git
- Development tools: git, wget, curl, jq, tree, htop

### 2. Installs Zsh Plugins
- `zsh-autosuggestions`: Fish-like autosuggestions
- `zsh-syntax-highlighting`: Syntax highlighting
- `fast-syntax-highlighting`: Faster syntax highlighting
- `zsh-256color`: 256 color support
- `colorize`: Syntax highlighting for cat
- `colored-man-pages`: Colorful man pages
- `kubectl`, `git`, `brew`, `golang`: Tool-specific plugins

### 3. Sets Up Monokai Theme
Creates a custom Monokai theme with:
- Custom color scheme for ls, grep, and man pages
- Git status integration in prompt
- Smart prompt with current directory, git branch, and status
- Time display in right prompt
- Command execution time reporting (for commands > 3 seconds)
- Up/down arrow history search

### 4. Configures Zsh
Creates a comprehensive `.zshrc` with:
- All plugins enabled
- Custom syntax highlighting styles
- Auto-completion for kubectl, helm, docker, etc.
- Useful aliases for kubectl and git
- Integration with NVM, pyenv, and Go
- Sources custom `.env` file for personal configurations

## Post-Installation Steps

### 1. Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 2. Customize Your Environment
Edit `~/.env` to add:
- Custom environment variables
- Personal aliases
- API keys and tokens
- Private repository configurations

Example:
```bash
# Edit the .env file
nano ~/.env

# Add your customizations
export MY_CUSTOM_VAR="value"
alias myalias="some command"
```

### 3. Install Additional Tools (Optional)

#### Krew (kubectl plugin manager)
```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

#### DigitalOcean CLI
```bash
brew install doctl
```

#### OpenShift CLI
```bash
brew install openshift-cli
```

### 4. Install Node.js
```bash
# Install latest LTS version
nvm install --lts

# Or install a specific version
nvm install 18.17.0

# Set default version
nvm alias default 18.17.0
```

### 5. Install Python
```bash
# Install Python version
pyenv install 3.11.0

# Set global Python version
pyenv global 3.11.0
```

## Features of the Monokai Theme

### Prompt Layout
```
~/path/to/directory main ● ●
```

- **Current directory**: Shows truncated path (50% of terminal width)
- **Git branch**: Shows current branch name in magenta
- **Git status indicators**:
  - Yellow ● = unstaged changes
  - Green ● = staged changes
- **Right prompt**: Shows timestamp and error indicator

### Special Indicators
- ✽ = Background jobs running
- ❖ = Shell is nested (more than 1 level deep)
- ★ = Running as root/sudo
- Red ● (right side) = Last command failed

### Colors
- Directory: White (bold)
- Git branch: Magenta
- Unstaged changes: Yellow
- Staged changes: Green
- Time: Dark gray
- Error: Red

## Included Aliases

### Kubernetes (kubectl)
```bash
k='kubectl'
kgp='kubectl get pods'
kgs='kubectl get svc'
kgd='kubectl get deployment'
kaf='kubectl apply -f'
kdel='kubectl delete'
klog='kubectl logs'
kexec='kubectl exec -it'
kctx='kubectx'
kns='kubens'
```

### Git
```bash
g='git'
gst='git status'
gco='git checkout'
gcm='git commit -m'
gaa='git add --all'
gp='git push'
gl='git pull'
glog='git log --oneline --decorate --graph'
gdiff='git diff'
lg='lazygit'
```

## Troubleshooting

### Theme Not Loading
If the Monokai theme doesn't load:
```bash
# Check if theme file exists
ls -la ~/.oh-my-zsh/custom/themes/monokai.zsh-theme

# Verify ZSH_THEME in .zshrc
grep ZSH_THEME ~/.zshrc

# Reload configuration
source ~/.zshrc
```

### Plugins Not Working
```bash
# Verify plugins are installed
ls ~/.oh-my-zsh/custom/plugins/

# Check plugins list in .zshrc
grep -A 15 "plugins=" ~/.zshrc

# Reinstall a specific plugin (example: zsh-autosuggestions)
rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
source ~/.zshrc
```

### Command Completions Not Working
```bash
# Rebuild zsh completions
rm -f ~/.zcompdump
compinit

# For specific tools, ensure they're installed
which kubectl  # Should show path
which helm     # Should show path
```

### NVM Not Loading
```bash
# Check NVM installation
ls -la ~/.nvm

# Manually load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Verify it's working
nvm --version
```

## Backup and Restore

The script automatically backs up your existing `.zshrc` to `.zshrc.backup.YYYYMMDD_HHMMSS`.

To restore a backup:
```bash
# List backups
ls -la ~/.zshrc.backup.*

# Restore a specific backup
cp ~/.zshrc.backup.20241023_120000 ~/.zshrc
source ~/.zshrc
```

## Customization Tips

### Change Theme Colors
Edit `~/.oh-my-zsh/custom/themes/monokai.zsh-theme` and modify the color definitions:
```bash
# Example: Change directory color from white to cyan
local cwd="${PR_CYAN}%B%${width}<…<%~%b"
```

### Add More Plugins
Edit `~/.zshrc` and add to the plugins array:
```bash
plugins=(
  git
  zsh-autosuggestions
  # ... existing plugins ...
  your-new-plugin
)
```

### Modify Aliases
Add custom aliases to `~/.env` instead of `.zshrc`:
```bash
# In ~/.env
alias myproject="cd ~/projects/my-project"
alias serve="python -m http.server 8000"
```

## File Locations

- **Oh My Zsh**: `~/.oh-my-zsh/`
- **Custom themes**: `~/.oh-my-zsh/custom/themes/`
- **Custom plugins**: `~/.oh-my-zsh/custom/plugins/`
- **Zsh config**: `~/.zshrc`
- **Custom env**: `~/.env`
- **NVM**: `~/.nvm/`
- **pyenv**: `~/.pyenv/`

## Additional Resources

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Zsh Documentation](http://zsh.sourceforge.net/Doc/)
- [NVM Documentation](https://github.com/nvm-sh/nvm)
- [pyenv Documentation](https://github.com/pyenv/pyenv)

## Support

If you encounter any issues:
1. Check the Troubleshooting section above
2. Review the script output for error messages
3. Ensure you're running the latest version of macOS
4. Verify Homebrew is properly installed: `brew doctor`
