
local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font("JetBrains Mono")
config.color_scheme = 'Wez (Gogh)'

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.window_frame = {
}

config.audible_bell = "Disabled"

config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.colors = {
    tab_bar = {
        background = '#0b0000',

        active_tab = {
            bg_color = '#0b0000',
            fg_color = 'yellow',
        },

        inactive_tab = {
            bg_color = '#0b0000',
            fg_color = '#ffffff',
        },

        new_tab = {
            bg_color = '#0b0000',
            fg_color = '#ffffff',
        }
    }
}

local bindings = require 'key-bindings'
config.keys = bindings.keys
config.leader = bindings.leader


return config
