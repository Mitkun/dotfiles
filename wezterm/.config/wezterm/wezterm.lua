local wezterm = require("wezterm")
local config = wezterm.config_builder()
local os = require("os")
local io = require("io")

math.randomseed(os.time())

config.front_end = "WebGpu"

local is_apple_silicon = wezterm.target_triple:find("aarch64") ~= nil
if is_apple_silicon then
	config.webgpu_power_preference = "HighPerformance"
else
	config.webgpu_power_preference = "LowPower"
end

-- =========================================================
-- Paths
-- =========================================================

local home = os.getenv("HOME")
local bg_folder = home .. "/.config/wezterm/backgrounds"
local default_bg = bg_folder .. "/default.jpg"

local current_bg = default_bg
local brightness = 0.05

-- =========================================================
-- Pick random background
-- =========================================================

local function pick_random_background(folder)
	local handle = io.popen('ls "' .. folder .. '"')
	if not handle then
		return nil
	end

	local result = handle:read("*a")
	handle:close()

	local images = {}
	for file in string.gmatch(result, "[^\n]+") do
		if file ~= "default.jpg" and (file:match("%.jpg$") or file:match("%.png$") or file:match("%.jpeg$")) then
			table.insert(images, file)
		end
	end

	if #images == 0 then
		return nil
	end

	return folder .. "/" .. images[math.random(#images)]
end

-- =========================================================
-- Appearance Configuration
-- =========================================================

config.window_background_image = default_bg

config.window_background_image_hsb = {
	brightness = brightness,
	hue = 1.0,
	saturation = 0.9,
}

if is_apple_silicon then
	-- Cấu hình cho MacBook Air M4
	config.macos_window_background_blur = 70
	config.window_background_opacity = 0.90
else
	-- Cấu hình cho MacBook Air 11" 2015 (Giảm tải cho GPU Intel cũ)
	config.macos_window_background_blur = 30 -- Giảm blur để máy không bị lag
	config.window_background_opacity = 0.95
end

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "Tokyo Night"

-- Font: Tự động chỉnh cỡ chữ cho phù hợp màn hình 11 inch (Intel) vs M4
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = is_apple_silicon and 16 or 13

config.native_macos_fullscreen_mode = true
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- =========================================================
-- Keybindings
-- =========================================================

config.keys = {

	-- BACKGROUND CONTROLS
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			local new_bg = pick_random_background(bg_folder)
			if new_bg then
				current_bg = new_bg
				window:set_config_overrides({
					window_background_image = current_bg,
				})
			end
		end),
	},

	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			current_bg = default_bg
			window:set_config_overrides({
				window_background_image = current_bg,
			})
		end),
	},

	{
		key = ">",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			brightness = math.min(brightness + 0.01, 1.0)
			window:set_config_overrides({
				window_background_image_hsb = {
					brightness = brightness,
					hue = 1.0,
					saturation = 0.9,
				},
			})
		end),
	},

	{
		key = "<",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			brightness = math.max(brightness - 0.01, 0.01)
			window:set_config_overrides({
				window_background_image_hsb = {
					brightness = brightness,
					hue = 1.0,
					saturation = 0.9,
				},
			})
		end),
	},

	-- SPLIT PANES
	{
		key = "\\",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CMD",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- MOVE BETWEEN PANES
	{ key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },

	-- RESIZE PANES
	{ key = "H", mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "L", mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "K", mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
	{ key = "J", mods = "CMD|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },

	-- CLOSE CONTROLS
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "W",
		mods = "CMD|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}

-- =========================================================
-- Cursor & Misc
-- =========================================================

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.scrollback_lines = 3500

return config
