#!/bin/bash

# Kubernetes Tools Installation Script
# Installs kubectl and OpenShift client

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Kubernetes Tools Installation"

# Check if running on macOS
check_macos

# Check if Homebrew is installed
check_homebrew

# Install kubectl
print_info "Installing kubectl..."
if command -v kubectl &> /dev/null; then
    print_success "kubectl is already installed: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
else
    brew install kubectl
    print_success "kubectl installed successfully"
fi

# Install OpenShift client (oc)
print_info "Installing OpenShift client (oc)..."
if command -v oc &> /dev/null; then
    print_success "OpenShift client is already installed: $(oc version --client)"
else
    brew install openshift-cli
    print_success "OpenShift client installed successfully"
fi

# Install additional Kubernetes tools
print_info "Installing additional Kubernetes tools..."

# Install kubectx and kubens for easy context and namespace switching
if ! command -v kubectx &> /dev/null; then
    brew install kubectx
    print_success "kubectx and kubens installed"
else
    print_info "kubectx is already installed"
fi

# Install k9s - Terminal UI for Kubernetes
if ! command -v k9s &> /dev/null; then
    brew install k9s
    print_success "k9s installed (Terminal UI for Kubernetes)"
else
    print_info "k9s is already installed"
fi

# Install helm - Kubernetes package manager
if ! command -v helm &> /dev/null; then
    brew install helm
    print_success "Helm installed"
else
    print_info "Helm is already installed: $(helm version --short)"
fi

# Install kustomize
if ! command -v kustomize &> /dev/null; then
    brew install kustomize
    print_success "kustomize installed"
else
    print_info "kustomize is already installed"
fi

# Create kubectl config directory
ensure_dir "$HOME/.kube"

# Add kubectl completion to zsh
print_info "Setting up kubectl shell completion..."
if ! grep -q 'kubectl completion' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
fi

# OpenShift client completion
if command -v oc &> /dev/null; then
    source <(oc completion zsh)
fi

# Helm completion
if command -v helm &> /dev/null; then
    source <(helm completion zsh)
fi
EOF
    print_success "Kubernetes tools completion added to ~/.zshrc"
else
    print_info "Kubernetes tools completion already configured"
fi

# Install useful kubectl aliases
print_info "Setting up kubectl aliases..."
if ! grep -q 'kubectl aliases' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

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
EOF
    print_success "kubectl aliases added to ~/.zshrc"
else
    print_info "kubectl aliases already configured"
fi

print_footer "Kubernetes tools installation completed!"
print_info "Installed tools:"
print_info "  - kubectl (Kubernetes CLI)"
print_info "  - oc (OpenShift CLI)"
print_info "  - kubectx/kubens (context and namespace switcher)"
print_info "  - k9s (Terminal UI for Kubernetes)"
print_info "  - helm (Kubernetes package manager)"
print_info "  - kustomize (Kubernetes configuration management)"
print_info ""
print_info "Useful commands:"
print_info "  k9s                     # Launch Kubernetes terminal UI"
print_info "  kubectx                 # List/switch contexts"
print_info "  kubens                  # List/switch namespaces"
print_info "  helm search hub <chart> # Search for Helm charts"
print_info ""
print_info "Restart your terminal or run: source ~/.zshrc"
