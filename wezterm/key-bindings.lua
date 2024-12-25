local wezterm = require 'wezterm'
local sessions = require 'sessions'

local M = {}

local function move_pane(key, direction)
	return {
		key = key,
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection(direction)
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize { direction, 3 }
	}
end

local leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 }

local keys = {
	{
		key = 's',
		mods = 'LEADER',
		action = wezterm.action.ShowLauncherArgs {
			flags = 'FUZZY|WORKSPACES',
		},
	},

	-- { key = 'r', mods = 'LEADER', action = wezterm.action.ReloadConfiguration, },
	{ key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
	{ key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
	{ key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
	{ key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },

	move_pane('h', 'Left'),
	move_pane('j', 'Down'),
	move_pane('k', 'Up'),
	move_pane('l', 'Right'),
	{
		key = 'r',
		mods = 'LEADER',
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable {
			name = 'resize_pane',
			-- Ensures the keytable stays active after it handles its
			-- first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 1000,
		}
	},
	{
		key = 'f',
		mods = 'LEADER',
		action = sessions.choose_project(),
	}
}

local key_tables = {
	resize_pane = {
		resize_pane('h', 'Left'),
		resize_pane('j', 'Down'),
		resize_pane('k', 'Up'),
		resize_pane('l', 'Right')
	}
}

M.setup = function(config)
	config.leader = leader
	config.keys = keys
	config.key_tables = key_tables
end

--[[
return {
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

return M
