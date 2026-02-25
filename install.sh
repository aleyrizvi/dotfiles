#!/bin/bash
set -e

# ─── macOS check ───────────────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  echo "This script only runs on macOS. Exiting."
  exit 1
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config-backup/$TIMESTAMP"

# ─── Helper functions ──────────────────────────────────────────
check_and_install() {
  local name="$1"
  local check_cmd="$2"
  local install_cmd="$3"

  if eval "$check_cmd" &>/dev/null; then
    echo "  [✓] $name"
  else
    echo "  [✗] $name — installing..."
    eval "$install_cmd"
    echo "  [✓] $name installed"
  fi
}

backup_if_exists() {
  local src="$1"
  local label="$2"
  if [[ -e "$src" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -r "$src" "$BACKUP_DIR/$label"
    echo "  Backed up $src → $BACKUP_DIR/$label"
  fi
}

# ─── Install dependencies ─────────────────────────────────────
echo ""
echo "Checking dependencies..."
echo ""

# Homebrew (must be first — others depend on it)
if command -v brew &>/dev/null; then
  echo "  [✓] brew"
else
  echo "  [✗] brew — installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "  [✓] brew installed"
fi

check_and_install "docker"     "command -v docker"     "brew install --cask docker"
check_and_install "golang"     "command -v go"         "brew install go"
check_and_install "rust"       "command -v rustc"      "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && source \"\$HOME/.cargo/env\""
check_and_install "nvm"        "[ -d \"\$HOME/.nvm\" ]" "brew install nvm && mkdir -p \"\$HOME/.nvm\""
check_and_install "nodejs"     "command -v node"       "export NVM_DIR=\"\$HOME/.nvm\" && [ -s \"/opt/homebrew/opt/nvm/nvm.sh\" ] && . \"/opt/homebrew/opt/nvm/nvm.sh\" && nvm install --lts"
check_and_install "typescript" "command -v tsc"        "npm install -g typescript"
check_and_install "tmux"       "command -v tmux"       "brew install tmux"
check_and_install "wezterm"    "command -v wezterm || [ -d /Applications/WezTerm.app ]" "brew install --cask wezterm"
check_and_install "gh"         "command -v gh"         "brew install gh"
check_and_install "claude"     "command -v claude"     "brew install claude"
check_and_install "windsurf"   "command -v windsurf || [ -d /Applications/Windsurf.app ]" "brew install --cask windsurf"
check_and_install "copilot-cli" "gh extension list | grep -q copilot" "gh extension install github/gh-copilot"

echo ""
echo "All dependencies satisfied."

# ─── Backup existing configs ──────────────────────────────────
echo ""
echo "Backing up existing configs ($TIMESTAMP)..."
echo ""

backup_if_exists "$HOME/.zshrc"       ".zshrc"
backup_if_exists "$HOME/.zshenv"      ".zshenv"
backup_if_exists "$HOME/.zprofile"    ".zprofile"
backup_if_exists "$HOME/.config/nvim" "nvim"
backup_if_exists "$HOME/.wezterm.lua" ".wezterm.lua"
backup_if_exists "$HOME/.tmux.conf"   ".tmux.conf"
backup_if_exists "$HOME/.config/tmux" "tmux"

if [[ -d "$BACKUP_DIR" ]]; then
  echo ""
  echo "Backups saved to $BACKUP_DIR"
else
  echo "  No existing configs found to back up."
fi

# ─── Copy configs from repo ───────────────────────────────────
echo ""
echo "Installing configs..."
echo ""

# zsh
cp "$SCRIPT_DIR/zsh/.zshrc"    "$HOME/.zshrc"
cp "$SCRIPT_DIR/zsh/.zshenv"   "$HOME/.zshenv"
cp "$SCRIPT_DIR/zsh/.zprofile" "$HOME/.zprofile"
echo "  [✓] zsh"

# nvim
mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/nvim"
cp -r "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
echo "  [✓] nvim"

# wezterm
cp "$SCRIPT_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
echo "  [✓] wezterm"

# tmux
cp "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
if [[ -d "$SCRIPT_DIR/tmux/plugins" ]]; then
  mkdir -p "$HOME/.config/tmux"
  cp -r "$SCRIPT_DIR/tmux/plugins" "$HOME/.config/tmux/plugins"
fi
echo "  [✓] tmux"

# Install tmux plugin manager if missing
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo ""
  echo "Installing tmux plugin manager (tpm)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "  [✓] tpm installed — run prefix + I inside tmux to install plugins"
fi

echo ""
echo "Done. Restart your terminal to apply changes."
