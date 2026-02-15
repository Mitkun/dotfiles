local wezterm = require("wezterm")
local config = {}

-- ======================
-- BASIC
-- ======================

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 15
config.color_scheme = "Tokyo Night"

config.window_decorations = "TITLE | RESIZE"
config.native_macos_fullscreen_mode = true
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

-- ======================
-- BACKGROUND SYSTEM
-- ======================

local bg_dir = wezterm.config_dir .. "/backgrounds"
local default_bg = bg_dir .. "/default.jpg"

local default_overlay_opacity = 0.75
local nvim_overlay_opacity = 0.85

local function list_backgrounds(folder)
	local handle = io.popen('ls "' .. folder .. '"')
	if not handle then
		return {}
	end
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for file in string.gmatch(result, "[^\n]+") do
		if file ~= "default.jpg" then
			table.insert(files, folder .. "/" .. file)
		end
	end
	return files
end

local backgrounds = list_backgrounds(bg_dir)

-- 👇 LƯU ẢNH HIỆN TẠI Ở ĐÂY
local current_bg = default_bg

local function make_background(path, overlay_opacity)
	return {
		{
			source = { File = path },
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = { Color = "#000000" },
			width = "100%",
			height = "100%",
			opacity = overlay_opacity,
		},
	}
end

config.background = make_background(current_bg, default_overlay_opacity)

-- ======================
-- RANDOM
-- ======================

local function apply_background(window, overlay)
	window:set_config_overrides({
		background = make_background(current_bg, overlay),
	})
end

local function random_background(window, overlay)
	if #backgrounds == 0 then
		return
	end
	current_bg = backgrounds[math.random(#backgrounds)]
	apply_background(window, overlay or default_overlay_opacity)
end

-- ======================
-- AUTO CHANGE 10 MIN
-- ======================

wezterm.on("update-status", function(window, pane)
	if not window._bg_timer then
		window._bg_timer = true

		local function schedule()
			wezterm.time.call_after(600, function()
				random_background(window, default_overlay_opacity)
				schedule()
			end)
		end

		schedule()
	end
end)

-- ======================
-- DARKEN WHEN NVIM
-- ======================

wezterm.on("update-right-status", function(window, pane)
	local process = pane:get_foreground_process_name()

	if process and process:find("nvim") then
		apply_background(window, nvim_overlay_opacity)
	else
		apply_background(window, default_overlay_opacity)
	end
end)

-- ======================
-- KEYBINDINGS
-- ======================

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			random_background(window, default_overlay_opacity)
		end),
	},
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			current_bg = default_bg
			apply_background(window, default_overlay_opacity)
		end),
	},
}

return config
