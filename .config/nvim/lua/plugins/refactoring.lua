local M = {}

M.spec = {
	'ThePrimeagen/refactoring.nvim',
	version = '*',
	ft = {
		-- 'astro',
		'go',
		'jsx',
		'javascript',
		'javascriptreact',
		'python',
		'tsx',
		'typescript',
		'typescriptreact',
		-- 'svelte',
	},

	dependencies = {
		{ 'nvim-treesitter/nvim-treesitter', optional = true },
	},

	opts = {
		prompt_func_return_type = {
			go = true,
			python = true,
		},
		print_var_statements = {
			-- astro = { 'console.log' },
			go = { 'fmt.Println' },
			jsx = { 'console.log' },
			javascript = { 'console.log' },
			javascriptreact = { 'console.log' },
			lua = { 'print' },
			python = { 'print' },
			-- svelte = { 'console.log' },
			tsx = { 'console.log' },
			typescript = { 'console.log' },
			typescriptreact = { 'console.log' },
		},
	},

	config = function(_, opts)
		require('refactoring').setup(opts)
	end,

	keys = {
		{
			'<leader>r',
			function()
				require('refactoring').select_refactor({
					show_success_message = true,
				})
			end,
			mode = 'v',
			desc = 'Refactor',
		},
	},
}

return M.spec
