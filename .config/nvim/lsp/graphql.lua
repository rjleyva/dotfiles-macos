local M = {}

M.spec = {
	cmd = {
		'graphql-lsp',
		'server',
		'-m',
		'stream',
	},

	filetypes = {
		-- 'astro',
		'graphql',
		'javascript',
		'javascriptreact',
		-- 'svelte',
		'typescriptreact',
		'typescript',
	},

	root_markers = {
		'.git',
		-- GraphQL config files
		'.graphqlrc',
		'.graphqlrc.json',
		'.graphqlrc.yaml',
		'.graphqlrc.yml',
		'.graphqlrc.js',
		'graphql.config.json',
		'graphql.config.js',
		'graphql.config.yaml',
		'graphql.config.yml',
	},

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,

	-- documentSelector = {
	--   { language = 'graphql', scheme = 'file' },
	--   { language = 'graphql', scheme = 'file', pattern = '**/*.astro' },
	-- },
}

M.name = 'graphql'

return M.spec
