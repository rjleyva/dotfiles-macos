vim.pack.add({
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

require('gitsigns').setup({
	signs_staged_enable = true,
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	watch_gitdir = {
		follow_files = false,
		interval = 15000,
	},
})
