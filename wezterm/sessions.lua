local wezterm = require 'wezterm'

local M = {}

local function project_dirs()
	local dirs = {
		wezterm.home_dir,
		wezterm.home_dir .. "/work",
		wezterm.home_dir .. "/misc",
	}

	wezterm.log_info(" -> " .. wezterm.home_dir .. "/misc")
	wezterm.glob(wezterm.home_dir .. "/misc")
	-- wezterm.log_info("project_dirs: " .. wezterm.glob(wezterm.home_dir .. "/work/*"))

	return dirs
end

function M.choose_project()
	local choices = {}
	for _, value in ipairs(project_dirs()) do
		table.insert(choices, { label = value })
	end

	return wezterm.action.InputSelector {
		title = 'Projects',
		choices = choices,
		fuzzy = true,
		action = wezterm.action_callback(function(child_window, child_pane, id, label)
			-- As a placeholder, we'll log the name of what you picked
			wezterm.log_info("you chose " .. label)
		end),
	}
end

return M
