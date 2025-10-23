#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Oh My Zsh + Monokai Theme Setup${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Function to print status messages
print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS only."
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    print_status "Homebrew is already installed."
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_status "Oh My Zsh is already installed."
fi

# Create custom plugins directory if it doesn't exist
mkdir -p ~/.oh-my-zsh/custom/plugins
mkdir -p ~/.oh-my-zsh/custom/themes

# Install zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    print_status "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    print_status "zsh-autosuggestions is already installed."
fi

# Install zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    print_status "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    print_status "zsh-syntax-highlighting is already installed."
fi

# Install fast-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
    print_status "Installing fast-syntax-highlighting..."
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
else
    print_status "fast-syntax-highlighting is already installed."
fi

# Install zsh-256color
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-256color" ]; then
    print_status "Installing zsh-256color..."
    git clone https://github.com/chrissicool/zsh-256color ~/.oh-my-zsh/custom/plugins/zsh-256color
else
    print_status "zsh-256color is already installed."
fi

# Install zsh-completions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
    print_status "Installing zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
else
    print_status "zsh-completions is already installed."
fi

# Create Monokai theme file
print_status "Creating Monokai theme..."
cat > ~/.oh-my-zsh/custom/themes/monokai.zsh-theme << 'THEME_EOF'
# ls colors
export CLICOLOR=1
export LSCOLORS=gxfxexdxcxegedabagacad

# grep colors
export GREP_OPTIONS='--color=auto'

# man colors
export LESS_TERMCAP_mb=$'\e[1;35m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# up / down arrow history navigation
zmodload zsh/zle
autoload -Uz +X add-zle-hook-widget
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# colors
autoload -U colors
colors

# prompt
setopt prompt_subst

# define colors
for COLOR in RED GREEN BLUE YELLOW MAGENTA WHITE BLACK CYAN; do
	eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
	eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
	eval TIME_$COLOR='$fg[${(L)COLOR}]'
	eval TIME_BRIGHT_$COLOR='$fg_bold[${(L)COLOR}]'
done

PR_RST="%{${reset_color}%}"
PR_RESET="%{%b%s%u$reset_color%}"
TIME_RESET="$reset_color"

# report command running time if it's more than 3 seconds
export REPORTTIME=3
export TIMEFMT="
${TIME_BRIGHT_BLACK}elapsed: ${TIME_WHITE}%*Es ${TIME_BRIGHT_BLACK}(user: ${TIME_WHITE}%*Us ${TIME_BRIGHT_BLACK}system: ${TIME_WHITE}%*Ss${TIME_BRIGHT_BLACK}) cpu: ${TIME_WHITE}%P ${TIME_BRIGHT_BLACK}memory: ${TIME_WHITE}%MK"

# completion
autoload -U compinit && compinit

setopt auto_list
setopt auto_menu
setopt always_to_end

zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
bindkey '^[[Z' reverse-menu-complete

# git regular status
autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "${PR_YELLOW}● "
zstyle ':vcs_info:*' stagedstr "${PR_GREEN}● "
zstyle ':vcs_info:*' formats "${PR_MAGENTA}%b %u%c${PR_RST}"
zstyle ':vcs_info:*' actionformats "${PR_MAGENTA}%b${PR_BRIGHT_BLACK} (${PR_CYAN}%a${PR_BRIGHT_BLACK}) %u%c${PR_RST}"

# git untracked files
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git

# calculate prompt width on window resize
function prompt_width() {
	echo $(( ${COLUMNS:-80} * 50 / 100 ))
}

# left prompt
function lprompt {
	# git info
	local git='$vcs_info_msg_0_'
	# reevaluate prompt width
	local width='$(prompt_width)'
	# truncate prompt
	local cwd="${PR_WHITE}%B%${width}<…<%~%b"
	# jobs are running in the background
	local jobs="%(1j.${PR_YELLOW}✽ .)"
	# shell is more than 1 level deeper than the initial shell level
	local level=$(( $INIT_SHELL_LEVEL + 1 ))
	local shell="%(${level}L.${PR_BLUE}❖ .)"
	# privileged or normal prompt
	# local cursor="${PR_RED}ツ"
	local cursor=""
	local p="%(!.${PR_MAGENTA}★ .${cursor})"

	PROMPT="${cwd} ${git}${jobs}${shell}${p}${PR_RESET}"
}

# new tab opens at current folder when corresponding terminal config is set
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
	function update_terminal_cwd() {
		local url_path=''

		{
			local i ch hexch LC_CTYPE=C LC_ALL=

			for ((i = 1; i <= ${#PWD}; ++i)); do
				ch="$PWD[i]"
				if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
					url_path+="$ch"
				else
					printf -v hexch "%02X" "'$ch"
					url_path+="%$hexch"
				fi
			done
		}

		printf '\e]7;%s\a' "file://$HOST$url_path"
	}

	autoload add-zsh-hook
	add-zsh-hook precmd update_terminal_cwd
fi

# right prompt
function rprompt {
	# 24 hour time
	local time="${PR_BRIGHT_BLACK}%D{%H:%M:%S}"
	# only show user when privileged
	local user="%(!.${PR_MAGENTA}%n .)"
	# show when command returned non-zero exit code
	local exit_status="%(1?.${PR_RED}● .)"

	RPROMPT="${PR_RESET}${exit_status}${user}${time}${PR_RESET}"
}

rprompt

# run before every command
function precmd() {
	vcs_info
	lprompt
	print ""
}
THEME_EOF

print_status "Monokai theme created successfully."

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    print_status "Backing up existing .zshrc to .zshrc.backup..."
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create new .zshrc
print_status "Creating new .zshrc configuration..."
cat > ~/.zshrc << 'ZSHRC_EOF'
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="monokai"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-256color
  colorize
  colored-man-pages
  kubectl
  branch
  brew
  command-not-found
  golang
)

source $ZSH/oh-my-zsh.sh

# ZSH syntax highlighting styles (must be set after Oh My Zsh is loaded)
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Go environment
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Docker completion
if command -v docker &> /dev/null; then
    autoload -Uz compinit && compinit
fi

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

# Helm completion
if command -v helm &> /dev/null; then
    source <(helm completion zsh)
fi

# doctl completion
if command -v doctl &> /dev/null; then
    source <(doctl completion zsh)
fi

# OpenShift client completion
if command -v oc &> /dev/null; then
    source <(oc completion zsh)
fi

# kubectl aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployment'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias klog='kubectl logs'
alias kexec='kubectl exec -it'
alias kctx='kubectx'
alias kns='kubens'

# Git aliases
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gaa='git add --all'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gdiff='git diff'
alias lg='lazygit'

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Krew (kubectl plugin manager)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Source .env file if it exists (for custom environment variables and aliases)
[ -f "$HOME/.env" ] && source "$HOME/.env"
ZSHRC_EOF

print_status ".zshrc created successfully."

# Install common development tools via Homebrew
print_status "Installing common development tools..."

# Essential tools
tools=(
    git
    wget
    curl
    jq
    tree
    htop
)

for tool in "${tools[@]}"; do
    if ! command -v $tool &> /dev/null; then
        print_status "Installing $tool..."
        brew install $tool
    else
        print_status "$tool is already installed."
    fi
done

# Install NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    print_status "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Load NVM for this session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    print_status "Installing latest LTS version of Node.js..."
    nvm install --lts
else
    print_status "NVM is already installed."
fi

# Install pyenv
if ! command -v pyenv &> /dev/null; then
    print_status "Installing pyenv..."
    brew install pyenv pyenv-virtualenv
    print_status "pyenv installed. You may want to install a Python version with: pyenv install 3.11.0"
else
    print_status "pyenv is already installed."
fi

# Install Go
if ! command -v go &> /dev/null; then
    print_status "Installing Go..."
    brew install go
else
    print_status "Go is already installed."
fi

# Install kubectl
if ! command -v kubectl &> /dev/null; then
    print_status "Installing kubectl..."
    brew install kubectl
else
    print_status "kubectl is already installed."
fi

# Optional: Install kubectx and kubens
if ! command -v kubectx &> /dev/null; then
    print_status "Installing kubectx and kubens..."
    brew install kubectx
else
    print_status "kubectx and kubens are already installed."
fi

# Optional: Install helm
if ! command -v helm &> /dev/null; then
    print_status "Installing Helm..."
    brew install helm
else
    print_status "Helm is already installed."
fi

# Optional: Install lazygit
if ! command -v lazygit &> /dev/null; then
    print_status "Installing lazygit..."
    brew install lazygit
else
    print_status "lazygit is already installed."
fi

# Create .env file template if it doesn't exist
if [ ! -f "$HOME/.env" ]; then
    print_status "Creating .env template file..."
    cat > ~/.env << 'ENV_EOF'
#!/bin/bash

# Add your custom environment variables and aliases here
# This file is sourced by .zshrc

# Example:
# export CUSTOM_VAR="value"
# alias custom_alias="command"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Go private repositories (customize as needed)
# go env -w GOPRIVATE="your-private-repo.com"
ENV_EOF
    print_status ".env template created. Edit ~/.env to add your custom configurations."
else
    print_status ".env file already exists."
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Close and reopen your terminal or run: source ~/.zshrc"
echo "2. Edit ~/.env to add any custom environment variables or aliases"
echo "3. Configure Git with your credentials:"
echo "   git config --global user.name 'Your Name'"
echo "   git config --global user.email 'your.email@example.com'"
echo ""
echo -e "${GREEN}Optional installations:${NC}"
echo "- Install krew (kubectl plugin manager): https://krew.sigs.k8s.io/docs/user-guide/setup/install/"
echo "- Install doctl (DigitalOcean CLI): brew install doctl"
echo "- Install oc (OpenShift CLI): brew install openshift-cli"
echo ""
echo -e "${YELLOW}Your old .zshrc has been backed up to .zshrc.backup.*${NC}"
echo ""
