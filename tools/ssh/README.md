# SSH Key Management

Setup and management of SSH keys for GitHub and other Git services.

## Overview

This tool helps you:
- Generate secure Ed25519 SSH keys
- Configure SSH for GitHub, GitLab, and Bitbucket
- Set up SSH agent for key management
- Configure proper permissions
- Copy public keys to clipboard for easy setup

## Why Ed25519?

Ed25519 keys are:
- More secure than RSA keys
- Smaller key size (better performance)
- Recommended by GitHub and modern security standards
- Resistant to certain types of attacks

## Installation

```bash
./install.sh
```

The installer will:
1. Prompt for your email address
2. Generate an Ed25519 key for GitHub
3. Add the key to ssh-agent
4. Configure SSH config file
5. Copy the public key to your clipboard
6. Optionally generate keys for GitLab and Bitbucket

## Generated Files

```
~/.ssh/
├── id_ed25519_github        # Private key for GitHub
├── id_ed25519_github.pub    # Public key for GitHub
├── id_ed25519_gitlab        # Private key for GitLab (optional)
├── id_ed25519_gitlab.pub    # Public key for GitLab (optional)
├── id_ed25519_bitbucket     # Private key for Bitbucket (optional)
├── id_ed25519_bitbucket.pub  # Public key for Bitbucket (optional)
└── config                    # SSH configuration
```

## Adding Keys to Services

### GitHub
1. Go to [GitHub SSH Keys Settings](https://github.com/settings/keys)
2. Click "New SSH key"
3. Paste your public key (already in clipboard)
4. Give it a descriptive title (e.g., "MacBook Pro 2024")
5. Click "Add SSH key"

### GitLab
1. Go to [GitLab SSH Keys Settings](https://gitlab.com/-/profile/keys)
2. Paste your public key
3. Add a title and expiration date (optional)
4. Click "Add key"

### Bitbucket
1. Go to [Bitbucket SSH Keys Settings](https://bitbucket.org/account/settings/ssh-keys/)
2. Click "Add key"
3. Paste your public key
4. Add a label
5. Click "Add key"

## Testing Connection

Test your SSH connection to each service:

```bash
# GitHub
ssh -T git@github.com

# GitLab
ssh -T git@gitlab.com

# Bitbucket
ssh -T git@bitbucket.org
```

Expected responses:
- GitHub: "Hi username! You've successfully authenticated..."
- GitLab: "Welcome to GitLab, @username!"
- Bitbucket: "logged in as username"

## SSH Config

The installer creates/updates `~/.ssh/config` with:

```ssh
# GitHub
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github
    AddKeysToAgent yes
    UseKeychain yes

# GitLab
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab
    AddKeysToAgent yes
    UseKeychain yes

# Bitbucket
Host bitbucket.org
    HostName bitbucket.org
    User git
    IdentityFile ~/.ssh/id_ed25519_bitbucket
    AddKeysToAgent yes
    UseKeychain yes
```

## Multiple GitHub Accounts

If you need to use multiple GitHub accounts:

1. Generate a new key:
   ```bash
   ssh-keygen -t ed25519 -C "work@example.com" -f ~/.ssh/id_ed25519_github_work
   ```

2. Add to SSH config:
   ```ssh
   # Personal GitHub
   Host github.com
       HostName github.com
       User git
       IdentityFile ~/.ssh/id_ed25519_github

   # Work GitHub
   Host github-work
       HostName github.com
       User git
       IdentityFile ~/.ssh/id_ed25519_github_work
   ```

3. Clone using the custom host:
   ```bash
   git clone git@github-work:company/repo.git
   ```

## Troubleshooting

### Permission Denied
- Check key permissions: `ls -la ~/.ssh/`
- Private keys should be 600
- Public keys should be 644
- .ssh directory should be 700

### Key Not Found
- Ensure ssh-agent is running: `eval "$(ssh-agent -s)"`
- Add key to agent: `ssh-add ~/.ssh/id_ed25519_github`

### Wrong Key Being Used
- Check which key is being used: `ssh -vT git@github.com`
- Verify SSH config is correct
- Use explicit identity file: `ssh -i ~/.ssh/id_ed25519_github -T git@github.com`

## Security Best Practices

1. **Use passphrases**: Always add a passphrase to your SSH keys
2. **Separate keys**: Use different keys for different services
3. **Rotate keys**: Replace keys periodically
4. **Remove old keys**: Delete unused keys from services
5. **Backup keys**: Keep secure backups of your keys
6. **Don't share private keys**: Never commit or share private keys

## Git Configuration

After setting up SSH, configure Git to use SSH for cloning:

```bash
# Use SSH by default for GitHub
git config --global url."git@github.com:".insteadOf "https://github.com/"

# Configure user
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```
