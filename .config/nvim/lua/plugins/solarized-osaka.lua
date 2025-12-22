local M = {}

M.spec = {
	'craftzdog/solarized-osaka.nvim',
	lazy = true,
	event = 'UIEnter',

	opts = {
		transparent = false,
		terminal_colors = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = { bold = true },
		},
	},

	config = function()
		vim.cmd([[colorscheme solarized-osaka]])
		vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
	end,
}

return M.spec
