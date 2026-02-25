# 🛠️ Personal Dotfiles

> Work in Progress - Building a comprehensive development environment configuration

This repository contains my personal dotfiles and configuration for a modern development workflow. Currently focused on Neovim, with plans to expand into a complete development environment setup.

## 📁 Current Configuration

### ✅ Neovim Configuration
**Location:** `/lua/` directory  
**Status:** ✅ Complete and actively maintained

- **Modern Neovim setup** using `lazy.nvim` plugin manager
- **LSP integration** with `vim.lsp.config` (modern API)
- **AI-powered coding** with Copilot.lua and nvim-cmp completion
- **Debugging support** with nvim-dap for multiple languages
- **Testing framework** with neotest integration
- **Advanced Go development** with Go.nvim (struct tags, code gen, testing)
- **Git integration** with LazyGit (`<leader>gg`), Snacks Git, and mini.diff for line indicators
- **File management** with Snacks.nvim explorer (`<leader>e`)
- **Project-wide search/replace** with Spectre.nvim
- **Enhanced diagnostics** with Trouble.nvim
- **Terminal integration** with ToggleTerm.nvim
- **Code formatting** with Conform.nvim and StyLua
- **Enhanced UI** with Noice.nvim and Catppuccin theme

**Key Features:**
- Full debugging workflow (Python, Go, Node.js, TypeScript)
- Comprehensive testing suite with multiple adapters
- Advanced Go development with auto-imports, struct tags, and code generation
- Tab completion for Copilot suggestions
- Advanced completion engine with snippet support
- Format-on-save with multiple language support
- Modern keybindings with organized groups
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

### Core Navigation & Files
| Binding | Action |
|---------|--------|
| `<leader>e` | File Explorer (Snacks) |
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fn` | New File |

### Git Operations (`<leader>g*`)
| Binding | Action |
|---------|--------|
| `<leader>gg` | LazyGit Interface |
| `<leader>gb` | Git Blame Line (Snacks) |
| `<leader>gs` | Git Status Terminal |
| `<leader>go` | Git Browse Open (Snacks) |
| `<leader>gho` | Toggle Diff Overlay |
| `<leader>ghs` | Stage Hunk/Selection |
| `<leader>ghr` | Reset Hunk/Selection |
| `<leader>ghd` | Set Diff Reference |
| `gh` | Apply/Reset Operator |
| `]h` / `[h` | Next/Previous Hunk |
| `]H` / `[H` | First/Last Hunk |

### Testing (`<leader>t*`)
| Binding | Action |
|---------|--------|
| `<leader>tr` | Run Nearest Test |
| `<leader>tf` | Run Current File Tests |
| `<leader>ta` | Run All Tests |
| `<leader>td` | Debug Nearest Test |
| `<leader>ts` | Toggle Test Summary |
| `<leader>tw` | Toggle Watch Mode |
| `<leader>tl` | Run Last Test |
| `<leader>tg` | Run Go Tests |
| `<leader>tF` | Test Go Function |
| `<leader>tc` | Go Test Coverage |
| `]t` / `[t` | Next/Previous Failed Test |

### Debugging (`<leader>d*`)
| Binding | Action |
|---------|--------|
| `<leader>dc` | Start/Continue Debug |
| `<leader>ds` | Step Over |
| `<leader>di` | Step Into |
| `<leader>do` | Step Out |
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>dr` | Open Debug REPL |
| `<leader>du` | Toggle Debug UI |
| `<leader>dt` | Terminate Debug |
| `<leader>dg` | Debug Go Program |
| `<leader>dT` | Debug Go Test |
| `<F5>` / `<F10>` / `<F11>` / `<F12>` | Debug F-keys |

### Diagnostics & Trouble (`<leader>x*`)
| Binding | Action |
|---------|--------|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace Diagnostics |
| `<leader>xd` | Document Diagnostics |
| `]d` / `[d` | Next/Previous Diagnostic |

### Search & Replace
| Binding | Action |
|---------|--------|
| `<leader>S` | Toggle Spectre Panel |
| `<leader>sw` | Search Current Word |
| `<leader>sp` | Search in Current File |

### Terminal (`<leader><C-*>`)
| Binding | Action |
|---------|--------|
| `<C-\>` | Toggle Float Terminal |
| `<leader><C-h>` | Horizontal Terminal |
| `<leader><C-v>` | Vertical Terminal |
| `<leader><C-f>` | Float Terminal |
| `<leader><C-n>` | Node REPL |
| `<leader><C-p>` | Python REPL |
| `<leader><C-g>` | Git Terminal |
| `<leader><C-a>` | Toggle All Terminals |

### Code Operations (`<leader>c*`)
| Binding | Action |
|---------|--------|
| `<leader>cd` | Show Diagnostics (Snacks) |
| `<leader>cD` | Buffer Diagnostics (Snacks) |
| `<leader>csj` | Add JSON struct tags |
| `<leader>csy` | Add YAML struct tags |
| `<leader>csr` | Remove struct tags |
| `<leader>cie` | Add if err block |
| `<leader>cfs` | Fill struct |
| `<leader>ccm` | Generate comment |
| `<leader>cim` | Implement interface |
| `<leader>cb` | Build Go project |
| `<leader>cr` | Run Go project |
| `<leader>cmt` | Go mod tidy |
| `<leader>cmi` | Go mod init |
| `<leader>cat` | Alternate test/source |
| `<leader>cav` | Alt vertical split |
| `<leader>cas` | Alt horizontal split |

### Completion & AI
| Binding | Action |
|---------|--------|
| `<Tab>` | Accept Copilot/CMP |
| `<C-j>` | Accept Copilot (Alt) |
| `<CR>` | Accept Completion |
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