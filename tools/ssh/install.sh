#!/bin/bash

# SSH Key Setup Script
# Generates Ed25519 SSH keys for GitHub and other services

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "SSH Key Setup"

# Check if running on macOS
check_macos

# Function to generate SSH key
generate_ssh_key() {
    local email="$1"
    local key_name="$2"
    local key_path="$HOME/.ssh/$key_name"
    
    if [ -f "$key_path" ]; then
        print_warning "SSH key already exists at $key_path"
        read -p "Do you want to generate a new key? This will overwrite the existing one. (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Keeping existing key"
            return 0
        fi
    fi
    
    print_info "Generating Ed25519 SSH key..."
    ssh-keygen -t ed25519 -C "$email" -f "$key_path"
    print_success "SSH key generated at $key_path"
    
    return 0
}

# Ensure .ssh directory exists with proper permissions
ensure_dir "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# Get user email for the key
print_info "Enter your GitHub email address:"
read -r email
if [ -z "$email" ]; then
    print_error "Email address is required"
    exit 1
fi

# Generate GitHub SSH key
print_info "Generating SSH key for GitHub..."
generate_ssh_key "$email" "id_ed25519_github"

# Add key to SSH agent
print_info "Adding SSH key to ssh-agent..."

# Start ssh-agent if not running
if ! pgrep -x ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Add key to agent
ssh-add -K "$HOME/.ssh/id_ed25519_github" 2>/dev/null || ssh-add "$HOME/.ssh/id_ed25519_github"
print_success "SSH key added to ssh-agent"

# Configure SSH config file
print_info "Configuring SSH config..."
SSH_CONFIG="$HOME/.ssh/config"

if ! grep -q "Host github.com" "$SSH_CONFIG" 2>/dev/null; then
    print_info "Adding GitHub configuration to SSH config..."
    cat >> "$SSH_CONFIG" << EOF

# GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    AddKeysToAgent yes
    UseKeychain yes
EOF
    print_success "GitHub SSH configuration added"
else
    print_info "GitHub configuration already exists in SSH config"
fi

# Set proper permissions
chmod 600 "$HOME/.ssh/config" 2>/dev/null || true
chmod 600 "$HOME/.ssh/id_ed25519_github" 2>/dev/null || true
chmod 644 "$HOME/.ssh/id_ed25519_github.pub" 2>/dev/null || true

# Copy public key to clipboard
print_info "Copying public key to clipboard..."
if command -v pbcopy &> /dev/null; then
    cat "$HOME/.ssh/id_ed25519_github.pub" | pbcopy
    print_success "Public key copied to clipboard!"
else
    print_warning "pbcopy not found. Here's your public key:"
    echo ""
    cat "$HOME/.ssh/id_ed25519_github.pub"
    echo ""
fi

# Generate additional keys for other services
print_info ""
read -p "Do you want to generate SSH keys for other services? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # GitLab
    read -p "Generate key for GitLab? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        generate_ssh_key "$email" "id_ed25519_gitlab"
        
        if ! grep -q "Host gitlab.com" "$SSH_CONFIG" 2>/dev/null; then
            cat >> "$SSH_CONFIG" << EOF

# GitLab
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab
    AddKeysToAgent yes
    UseKeychain yes
EOF
        fi
    fi
    
    # Bitbucket
    read -p "Generate key for Bitbucket? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        generate_ssh_key "$email" "id_ed25519_bitbucket"
        
        if ! grep -q "Host bitbucket.org" "$SSH_CONFIG" 2>/dev/null; then
            cat >> "$SSH_CONFIG" << EOF

# Bitbucket
Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_ed25519_bitbucket
    AddKeysToAgent yes
    UseKeychain yes
EOF
        fi
    fi
fi

print_footer "SSH key setup completed!"
print_info ""
print_info "Next steps:"
print_info "1. Your public key has been copied to the clipboard"
print_info "2. Go to GitHub Settings → SSH and GPG keys"
print_info "3. Click 'New SSH key'"
print_info "4. Paste the key and give it a descriptive title"
print_info "5. Test the connection with: ssh -T git@github.com"
print_info ""
print_info "Your SSH keys are located at:"
print_info "  - GitHub: ~/.ssh/id_ed25519_github"
if [ -f "$HOME/.ssh/id_ed25519_gitlab" ]; then
    print_info "  - GitLab: ~/.ssh/id_ed25519_gitlab"
fi
if [ -f "$HOME/.ssh/id_ed25519_bitbucket" ]; then
    print_info "  - Bitbucket: ~/.ssh/id_ed25519_bitbucket"
fi
