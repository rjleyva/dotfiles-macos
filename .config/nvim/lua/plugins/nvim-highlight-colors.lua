vim.pack.add({
	{ src = 'https://github.com/brenoprata10/nvim-highlight-colors' },
})

require('nvim-highlight-colors').setup({
	render = 'virtual', -- 'background', 'foreground', 'virtual'
	enable_named_colors = true,
	enable_tailwind = true,
	enable_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_var_usage = true,
	virtual_symbol = '●',
})
