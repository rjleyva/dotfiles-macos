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
		background = "#1d2021",
		foreground = "#ebdbb2",

		cursor_bg = "#ebdbb2",
		cursor_fg = "#1d2021",
		cursor_border = "#ebdbb2",

		selection_bg = "#3c3836",
		selection_fg = "#ebdbb2",

		ansi = {
			"#1d2021",
			"#cc241d",
			"#98971a",
			"#d79921",
			"#458588",
			"#b16286",
			"#689d6a",
			"#a89984",
		},

		brights = {
			"#928374",
			"#fb4934",
			"#b8bb26",
			"#fabd2f",
			"#83a598",
			"#d3869b",
			"#8ec07c",
			"#ebdbb2",
		},
	},
}

return M.spec

