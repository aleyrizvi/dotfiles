# Dotfiles

Personal macOS development environment configuration for Neovim, Tmux, WezTerm, and Zsh.

## Structure

```
dotfiles/
├── install.sh              # One-command setup script
├── nvim/                   # Neovim configuration (lazy.nvim)
│   ├── init.lua
│   └── lua/
│       ├── config/         # Core settings, keymaps, plugin bootstrap
│       └── plugins/        # 20+ plugin configs
├── tmux/                   # Tmux configuration
│   ├── .tmux.conf
│   └── plugins/catppuccin/ # Catppuccin theme (vendored)
├── wezterm/                # WezTerm terminal config
│   └── .wezterm.lua
└── zsh/                    # Zsh shell configuration
    ├── .zshrc
    ├── .zshenv
    └── .zprofile
```

## Quick Start

```bash
git clone git@github.com:aleyrizvi/dotfiles.git
cd dotfiles
chmod +x install.sh
./install.sh
```

The install script will:

1. Verify macOS and install dependencies (Homebrew, Docker, Go, Rust, Node.js, Tmux, WezTerm, Claude Code, Windsurf, GitHub Copilot CLI)
2. Back up existing configs to `~/.config-backup/<timestamp>/`
3. Symlink/copy all configs to their expected locations
4. Install tmux plugin manager (tpm) if missing

## Neovim

Built on **Neovim 0.10+** with [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

**Theme:** Catppuccin Mocha (with Gruvbox Material, Nordic, GitHub alternatives available)

### Language Support

| Language   | LSP Server       | Debug | Test | Format |
|------------|------------------|-------|------|--------|
| Go         | gopls            | Yes   | Yes  | Yes    |
| Python     | pyright          | Yes   | Yes  | -      |
| TypeScript | ts_ls            | Yes   | Yes  | -      |
| Rust       | rust_analyzer    | -     | Yes  | -      |
| Lua        | lua_ls           | -     | -    | StyLua |
| JSON/YAML  | jsonls/yamlls    | -     | -    | -      |
| Bash       | bashls           | -     | -    | -      |

### Key Plugins

- **Blink.cmp** - Completion engine with snippet support
- **GitHub Copilot** - AI code suggestions + CopilotChat
- **Snacks.nvim** - File explorer, fuzzy picker, git tools, notifications
- **Neotest** - Test runner (Go, Python, JS/TS, Rust)
- **nvim-dap** - Debug adapter protocol
- **go.nvim** - Go development (auto-imports, struct tags, code gen)
- **Trouble.nvim** - Diagnostics panel
- **Conform.nvim** - Format on save
- **LazyGit** - Git UI
- **ToggleTerm** - Multiple terminal instances
- **Spectre** - Project-wide search and replace
- **Noice.nvim** - Enhanced UI for messages, cmdline, popupmenu
- **Which-key** - Keybinding cheatsheet

### Key Bindings

| Binding              | Action                    |
|----------------------|---------------------------|
| `jk`                 | Exit insert mode          |
| `<leader>e`          | File explorer             |
| `<leader>ff`         | Find files                |
| `<leader>fg`         | Live grep                 |
| `<leader>fb`         | Buffer picker             |
| `<leader>gg`         | LazyGit                   |
| `<leader>tr`         | Run nearest test          |
| `<leader>dc`         | Start/continue debug      |
| `<leader>db`         | Toggle breakpoint         |
| `<C-\>`              | Toggle float terminal     |
| `<C-s>`              | Save                      |
| `ss` / `sv`          | Split horizontal/vertical |

## Tmux

- Vi keybindings in copy mode
- Pane navigation: `prefix + h/j/k/l`
- Window jumping: `Alt + 1-9`
- Git-aware status bar (branch, modified, untracked, ahead/behind)
- Gruvbox Material dark theme
- Plugin manager: [tpm](https://github.com/tmux-plugins/tpm) (run `prefix + I` to install plugins)

## WezTerm

- Color scheme: Catppuccin Mocha
- Font: JetBrainsMono Nerd Font (16pt)
- Tab bar hidden for single tabs
- Option key configured for Neovim compatibility

## Zsh

- Framework: oh-my-zsh
- Prompt: [Pure](https://github.com/sindresorhus/pure)
- Plugins: git, zsh-autosuggestions
- Alias: `vim` → `nvim`
- Configured paths: Go, Rust (Cargo), Android SDK, Python 3.12, JetBrains Toolbox

## AI & CLI Tools

Installed automatically by the setup script:

- **[Claude Code](https://claude.com/claude-code)** - Anthropic's CLI for Claude
- **[Windsurf](https://windsurf.com)** - AI-powered IDE
- **[GitHub Copilot CLI](https://docs.github.com/en/copilot/github-copilot-in-the-cli)** - AI assistance in the terminal (`gh copilot`)

## Requirements

- macOS
- [Homebrew](https://brew.sh) (installed automatically)
- [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono recommended)
