vim.pack.add({
	'https://github.com/tpope/vim-dadbod',
	'https://github.com/kristijanhusak/vim-dadbod-completion',
	'https://github.com/kristijanhusak/vim-dadbod-ui',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'sql',
		'mysql',
		'plsql',
		'graphql',
	},

	callback = function()
		local cmp = require('cmp')

		cmp.setup.buffer({
			sources = cmp.config.sources({
				{ name = 'vim-dadbod-completion' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path' },
				{ name = 'buffer' },
			}),
		})
	end,
})

vim.g.db_ui_use_nerd_fonts = 1

vim.keymap.set('n', '<leader>db', '<cmd>DBUI<cr>')
vim.keymap.set('n', '<leader>dt', '<cmd>DBUIToggle<cr>')
vim.keymap.set('n', '<leader>da', '<cmd>DBUIAddConnection<cr>')
vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<cr>')
