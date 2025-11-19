local M = {}

M.spec = {
	'tpope/vim-dadbod',
	ft = { 'sql', 'mysql', 'plsql', 'graphql' },

	dependencies = {
		{
			'kristijanhusak/vim-dadbod-completion',
			ft = { 'sql', 'mysql', 'plsql', 'graphql' },
			config = function()
				local cmp = require('cmp')

				local sql_sources = cmp.config.sources({
					{ name = 'vim-dadbod-completion' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
					{ name = 'buffer' },
				})

				cmp.setup.filetype({ 'sql', 'mysql', 'plsql', 'graphql' }, {
					sources = sql_sources,
				})
			end,
		},

		{
			'kristijanhusak/vim-dadbod-ui',
			version = '*',
			cmd = {
				'DBUI',
				'DBUIToggle',
				'DBUIAddConnection',
				'DBUIFindBuffer',
			},

			keys = function()
				return {
					{ '<leader>db', '<cmd>DBUI<cr>', desc = 'Open Database UI' },
					{ '<leader>dt', '<cmd>DBUIToggle<cr>', desc = 'Toggle Database UI' },
					{
						'<leader>da',
						'<cmd>DBUIAddConnection<cr>',
						desc = 'Add DB Connection',
					},
					{ '<leader>df', '<cmd>DBUIFindBuffer<cr>', desc = 'Find DB Buffer' },
				}
			end,
			init = function()
				vim.g.db_ui_use_nerd_fonts = 1
			end,
		},
	},
}

return M.spec
