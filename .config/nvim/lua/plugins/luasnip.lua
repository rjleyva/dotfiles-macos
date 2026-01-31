vim.pack.add({
	{
		src = 'https://github.com/L3MON4D3/LuaSnip',
		build = 'make install_jsregexp',
	},
	{
		src = 'https://github.com/rafamadriz/friendly-snippets',
	},
})

local luasnip = require('luasnip')

luasnip.config.setup({
	history = true,
	updateevents = 'TextChanged,TextChangedI',
	enable_autosnippets = true,
})

require('luasnip.loaders.from_vscode').lazy_load({
	include = {
		'css',
		'graphql',
		'go',
		'html',
		'javascript',
		'javascriptreact',
		'json',
		'lua',
		'markdown',
		'python',
		'typescript',
		'typescriptreact',
		'yaml',
	},
})
