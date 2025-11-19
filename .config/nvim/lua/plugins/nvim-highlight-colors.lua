local M = {}

M.spec = {
	'brenoprata10/nvim-highlight-colors',
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		render = 'virtual', -- 'background', 'foreground', 'virtual'
		enable_named_colors = true,
		enable_tailwind = true,
		enable_hex = true,
		enable_rgb = true,
		enable_hsl = true,
		enable_var_usage = true,
		virtual_symbol = '●',
	},
}

return M.spec
