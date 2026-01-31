vim.pack.add({
	{ src = 'https://github.com/stevearc/conform.nvim' },
})

require('conform').setup({
	format_on_save = {
		lsp_format = 'never',
		timeout_ms = 5000,
	},

	formatters_by_ft = {
		['_'] = { 'codespell', 'trim_whitespace' },
		astro = { 'prettier' },
		css = { 'prettier' },
		go = { 'goimports', 'gofmt' },
		graphql = { 'prettier' },
		html = { 'prettier' },
		javascript = { 'prettier' },
		javascriptreact = { 'prettier' },
		json = { 'prettier' },
		lua = { 'stylua' },
		markdown = { 'prettier' },
		python = { 'isort', 'black' },
		sh = { 'shfmt' },
		svelte = { 'prettier' },
		sql = { 'sql-formatter' },
		typescript = { 'prettier' },
		typescriptreact = { 'prettier' },
		yaml = { 'prettier' },
	},
})
