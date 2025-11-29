# 🛠️ Personal Dotfiles

> Work in Progress - Building a comprehensive development environment configuration

This repository contains my personal dotfiles and configuration for a modern development workflow. Currently focused on Neovim, with plans to expand into a complete development environment setup.

## 📁 Current Configuration

### ✅ Neovim Configuration
**Location:** `/lua/` directory  
**Status:** ✅ Complete and actively maintained

- **Modern Neovim setup** using `lazy.nvim` plugin manager
- **LSP integration** with `vim.lsp.config` (modern API)
- **AI-powered coding** with Copilot.lua
- **Git integration** with LazyGit (`<leader>gg`)
- **File management** with Snacks.nvim explorer (`<leader>e`)
- **Code formatting** with Conform.nvim and StyLua
- **Enhanced UI** with Noice.nvim and Catppuccin theme

**Key Features:**
- Tab completion for Copilot suggestions
- Format-on-save with multiple language support
- Modern keybindings with which-key integration
- Comprehensive LSP setup for multiple languages

## 🚧 Planned Additions

### Roadmap Checklist

- [ ] **WezTerm Configuration**
  - Modern terminal emulator config
  - Custom themes and keybindings
  - Integration with development workflow

- [ ] **Tmux Configuration**
  - Session management setup
  - Custom key bindings and themes
  - Integration with terminal workflow

- [ ] **Installation Scripts**
  - Automated dotfiles installation
  - Package manager setup (Homebrew, etc.)
  - Dependency management

- [ ] **Shell Configuration**
  - Zsh/Fish shell setup
  - Custom aliases and functions
  - Environment variable management

- [ ] **Development Tools**
  - Git configuration and aliases
  - Development environment setup
  - Language-specific tooling

- [ ] **System Configuration**
  - macOS system preferences
  - Application configurations
  - Security and privacy settings

## 🚀 Quick Start (Neovim)

1. **Prerequisites:**
   ```bash
   # Install Neovim (0.10+)
   brew install neovim
   
   # Install required tools
   brew install stylua lazygit node
   ```

2. **Install Configuration:**
   ```bash
   # Backup existing config (if any)
   mv ~/.config/nvim ~/.config/nvim.backup
   
   # Clone this repository
   git clone <repository-url> ~/.config/nvim
   
   # Launch Neovim (plugins will auto-install)
   nvim
   ```

3. **Post-Installation:**
   ```bash
   # Authenticate Copilot
   :Copilot auth
   
   # Check health
   :checkhealth
   ```

## 📋 Key Bindings

| Binding | Action |
|---------|--------|
| `<leader>gg` | LazyGit |
| `<leader>e` | File Explorer |
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<Tab>` | Accept Copilot |
| `<C-s>` | Save File |

*Leader key is `<Space>`*

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:
- ⭐ Star if you find it useful
- 🍴 Fork for your own setup
- 💡 Open issues for suggestions
- 📖 Check `AGENTS.md` for development guidelines

## 📄 License

MIT License - Feel free to use and modify for your own setup.

---

**Status:** 🚧 Work in Progress  
**Last Updated:** November 2024  
**Neovim Version:** 0.10+