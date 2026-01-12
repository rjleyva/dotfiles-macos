local wezterm = require("wezterm")

local M = {}

M.spec = {
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_background_opacity = 1,
	macos_window_background_blur = 10,
	font = wezterm.font_with_fallback({ "Lilex Nerd Font" }),
	font_size = 18,
	scrollback_lines = 10000,

	colors = {
		foreground = "#cdcdcd",
		background = "#141415",
		cursor_bg = "#cdcdcd",
		cursor_fg = "#141415",
		cursor_border = "#cdcdcd",
		selection_bg = "#405065",
		selection_fg = "#cdcdcd",

		ansi = {
			"#141415",
			"#d8647e",
			"#7fa563",
			"#f3be7c",
			"#6e94b2",
			"#bb9dbd",
			"#9bb4bc",
			"#cdcdcd",
		},

		brights = {
			"#1c1c24",
			"#d8647e",
			"#7fa563",
			"#f3be7c",
			"#6e94b2",
			"#bb9dbd",
			"#9bb4bc",
			"#cdcdcd",
		},
	},
}

return M.spec
