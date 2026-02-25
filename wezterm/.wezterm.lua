local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- 🖌️ Appearance
-- config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme = "Catppuccin Mocha" -- or "Catppuccin Mocha", etc.
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16
-- config.window_decorations = "RESIZE"

-- Zellij integration
-- config.default_prog = { "/opt/homebrew/bin/zellij", "-l", "welcome" }

-- 📦 Hide WezTerm UI elements since tmux handles it
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- 🔧 Option key configuration for Neovim
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Explicit key mappings for Cmd+Option combinations
config.keys = config.keys or {}
table.insert(config.keys, {
	key = 'j',
	mods = 'CMD|ALT',
	action = wezterm.action.SendKey { key = 'j', mods = 'CMD|ALT' },
})
table.insert(config.keys, {
	key = 'k', 
	mods = 'CMD|ALT',
	action = wezterm.action.SendKey { key = 'k', mods = 'CMD|ALT' },
})

return config
