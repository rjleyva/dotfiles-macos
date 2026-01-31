local M = {}

M.spec = {
	cmd = { 'sql-language-server', 'up', '--method', 'stdio' },

	filetypes = {
		'sql',
		'mysql',
		-- 'plsql',
		-- 'pgsql',
		-- 'sqlite',
	},

	root_markers = {
		'.git',
		-- SQL-specific project markers
		'db.sql',
		'init.sql',
		'schema.sql',
		'migrations',

		-- Database config files
		'docker-compose.yml',
		'docker-compose.yaml',

		-- Project markers that might indicate database usage
		'package.json',
		'composer.json',
		'requirements.txt',
		'go.mod',
	},

	settings = {
		sqlLanguageServer = {
			connections = {}, --  project-specific

			lint = {
				rules = {
					-- Use 'warning' instead of 'error' for better compatibility
					['align-column-to-the-first'] = 'warning',
					['column-new-line'] = 'warning',
					['linebreak-after-clause-keyword'] = 'warning',
					['reserved-word-case'] = { 'warning', 'upper' },
					['align-where-clause-to-the-first'] = 'warning',
				},
			},

			-- Keep completion settings but make them more flexible
			completion = {
				keywordCase = 'preserve',
				alwaysSelect = false,
				snippetSupport = true,
			},

			-- REMOVED: Let conform handle formatting via sql-formatter

			-- Keep basic file associations
			fileAssociations = {
				{
					pattern = '**/*.sql',
					scheme = 'file',
				},
			},
		},
	},

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'sqlls'

return M.spec
