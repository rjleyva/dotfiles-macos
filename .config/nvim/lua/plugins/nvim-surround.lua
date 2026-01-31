vim.pack.add({
	{ src = 'https://github.com/kylechui/nvim-surround' },
})

require('nvim-surround').setup({
	{ 'ys', desc = 'Add surrounding', mode = 'n' },
	{ 'yss', desc = 'Add surrounding to line', mode = 'n' },
	{ 'ds', desc = 'Delete surrounding', mode = 'n' },
	{ 'cs', desc = 'Change surrounding', mode = 'n' },
	{ 'S', desc = 'Add surrounding (Visual)', mode = 'v' },
})
