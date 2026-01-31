vim.pack.add({
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
})

require('mason').setup()

-- LSP servers
require('mason-lspconfig').setup({
	ensure_installed = {
		'astro',
		'cssls',
		'emmet_language_server',
		'eslint',
		'gopls',
		'graphql',
		'html',
		'jsonls',
		'lua_ls',
		'marksman',
		'pyright',
		'svelte',
		'sqlls',
		'vtsls',
		'yamlls',
	},
	automatic_installation = true,
})

-- Non-LSP tools
require('mason-tool-installer').setup({
	ensure_installed = {
		'eslint_d',
		'prettier',
		'stylua',
	},
	run_on_start = true,
})
