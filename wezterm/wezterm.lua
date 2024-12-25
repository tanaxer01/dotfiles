local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local COLORSCHEME = 'Tokyo Night'

config.color_scheme = COLORSCHEME
config.font = wezterm.font({ family = "JetBrains Mono" })
config.font_size = 11

-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'RESIZE'

-- Sets the font for the window frame (tab bar)
config.window_frame = {
	-- Berkeley Mono for me again, though an idea could be to try a
	-- serif font here instead of monospace for a nicer look?
	font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
	font_size = 12,

	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}
-- config.tab_bar_at_bottom = true

config.window_padding = {
	left = 10,
	right = 10,
	top = 0,
	bottom = 0,
}
config.audible_bell = "Disabled"

wezterm.on('update-status', function(window)
	local color_scheme = window:effective_config().resolved_palette
	local bg = color_scheme.background
	local fg = color_scheme.foreground

	window:set_right_status(wezterm.format({
		-- First, we draw the arrow...
		{ Background = { Color = 'none' } },
		{ Foreground = { Color = bg } },
		{ Text = '<' },
		-- Then we draw our text
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = ' ' .. wezterm.mux.get_active_workspace() .. '  ' },
	}))
end)

require('key-bindings').setup(config)

config.colors = {}

return config
