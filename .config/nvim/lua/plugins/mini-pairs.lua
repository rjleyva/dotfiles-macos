vim.pack.add({
	{ src = 'https://github.com/echasnovski/mini.pairs' }
})

require('mini.pairs').setup({
	modes = { insert = true, command = true, terminal = false },
	skip_ts = { 'string' },
	skip_unbalanced = true,
})
