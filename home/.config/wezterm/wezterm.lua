-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
config.font = wezterm.font("FiraCode Nerd Font")
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
}

wezterm.on("user-var-changed", function(window, pane, name, value)
	wezterm.log_info("var", name, value)
	if name == "wez_not" then
		window:toast_notification("wezterm", "msg: " .. value, nil, 1000)
	end

	if name == "wez_copy" then
		window:copy_to_clipboard(value, "Clipboard")
	end
end)
-- and finally, return the configuration to wezterm
return config
