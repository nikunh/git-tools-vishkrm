#!/bin/sh
set -e

# Logging mechanism for debugging
LOG_FILE="/tmp/git-tools-install.log"
log_debug() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [DEBUG] $*" >> "$LOG_FILE"
}

# Initialize logging
log_debug "=== GIT-TOOLS INSTALL STARTED ==="
log_debug "Script path: $0"
log_debug "PWD: $(pwd)"
log_debug "Environment: USER=$USER HOME=$HOME"

echo "Installing Git Tools feature..."

# Set DEBIAN_FRONTEND to noninteractive to prevent prompts
export DEBIAN_FRONTEND=noninteractive

# 1. Install prerequisite tools
apt-get update
apt-get install -y --no-install-recommends curl software-properties-common

# Add PPA for diff-so-fancy
add-apt-repository ppa:aos1/diff-so-fancy -y

# 2. Install standard Git tools from apt
apt-get update
apt-get install -y --no-install-recommends \
    git \
    git-lfs \
    git-flow \
    tig \
    diff-so-fancy

# 3. Install GitHub CLI (gh) by adding its official repository
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list

apt-get update
apt-get install -y gh

# 4. Clean up apt lists
rm -rf /var/lib/apt/lists/*

echo "Git Tools feature installed successfully."

log_debug "=== GIT-TOOLS INSTALL COMPLETED ==="
# Auto-trigger build Tue Sep 23 20:03:13 BST 2025
# Auto-trigger build Sun Sep 28 03:45:07 BST 2025
