# AGENTS.md - Neovim Configuration Codebase Guide

## Build/Lint/Test Commands
- **Format:** `stylua .` (formats all Lua files with 2-space indent, 100-char width)
- **Check config:** `nvim --headless -c "checkhealth" -c "qa"` 
- **Plugin management:** Launch `nvim`, then `:Lazy install|update|check`
- **LSP check:** `nvim --headless -c "lua print(vim.inspect(vim.lsp.get_active_clients()))" -c "qa"`

## Code Style Guidelines
- **Indentation:** 2 spaces (configured in `.stylua.toml`)
- **Line length:** 100 characters max
- **Strings:** Double quotes when needed
- **Tables:** Trailing commas preferred
- **Imports:** Use `require()` at function scope for lazy loading
- **Plugin pattern:** One plugin per file in `lua/plugins/[name].lua` returning table

## File Organization
- `init.lua` → Entry point, loads `config.lazy`
- `lua/config/` → Core config (options, keymaps, lazy setup)  
- `lua/plugins/` → Individual plugin configs (auto-imported by lazy.nvim)
- Modern pattern: `vim.lsp.config.server_name = { ... }` (not deprecated lspconfig)

## Key Conventions
- **Leader key:** Space character
- **Keymaps:** Use `vim.keymap.set()`, prefer descriptive opts table
- **Groups:** `<leader>f*` (files), `<leader>g*` (git), `<leader>z*` (zen)
- **Error handling:** Use `vim.diagnostic.config()` and proper autocmd patterns

## Testing Changes
1. Save files → Format with StyLua automatically (format-on-save enabled)
2. Launch `nvim` to test configuration loading
3. Check `:messages` for any errors
4. Verify plugin functionality with respective commands