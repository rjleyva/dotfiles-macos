local wezterm = require("wezterm")

local M = {}

M.spec = {
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_background_opacity = 1.0,
	macos_window_background_blur = 10,
	font = wezterm.font_with_fallback({ "Lilex Nerd Font" }),
	font_size = 18,
	scrollback_lines = 10000,

	colors = {
		foreground = "#839395",
		background = "#001419",
		cursor_bg = "#839395",
		cursor_fg = "#001419",
		cursor_border = "#839395",
		selection_bg = "#1a6397",
		selection_fg = "#839395",

		ansi = {
			"#001014",
			"#db302d",
			"#849900",
			"#b28500",
			"#268bd3",
			"#d23681",
			"#29a298",
			"#9eabac",
		},

		brights = {
			"#001419",
			"#db302d",
			"#849900",
			"#b28500",
			"#268bd3",
			"#d23681",
			"#29a298",
			"#839395",
		},
	},
}

return M.spec
