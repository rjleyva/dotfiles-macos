vim.lsp.enable({
	'astro',
	'cssls',
	'emmet-language-server',
	'eslint',
	'gopls',
	'graphql',
	'html',
	'jsonls',
	'lua_ls',
	'marksman',
	'pyright',
	'svelte',
	'sql-language-server',
	'vtsls',
	'yamlls',
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
		},
	},
})

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = true,
	},
	signs = {
		text = {
			-- [vim.diagnostic.severity.ERROR] = '󰅚 ',
			-- [vim.diagnostic.severity.WARN] = '󰀪 ',
			-- [vim.diagnostic.severity.INFO] = '󰋽 ',
			-- [vim.diagnostic.severity.HINT] = '󰌶 ',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.WARN] = 'WarningMsg',
		},
	},
})
