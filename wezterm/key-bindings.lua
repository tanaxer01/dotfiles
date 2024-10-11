
local wezterm = require 'wezterm'
local act = wezterm.action

return {}

--[[
return {
    leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration, },
        { key = 'x', mods = 'LEADER', action = wezterm.action.ActivateCommandPalette, },
        -- { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
        {
            key = 's',
            mods = 'LEADER',
            action = act.ShowLauncherArgs {
                flags = 'FUZZY|WORKSPACES',
            },
        },

        { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },

        { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

        {
            key = '%',
            mods = 'LEADER',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = '"',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
    }
}
--]]
