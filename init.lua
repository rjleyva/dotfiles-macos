-- Core
vim.g.mapleader = ' '
vim.g.mouse = ''
vim.g.deprecation_warnings = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.laststatus = 1
vim.opt.signcolumn = 'yes'
vim.opt.winborder = 'rounded'

-- Editing
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.conceallevel = 0
vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

-- General Keymaps
-- Update & source
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
-- Clear search highlights
vim.keymap.set('n', '<leader>cs', vim.cmd.nohlsearch)

-- Plugins
vim.pack.add({
	{ src = 'https://github.com/morhetz/gruvbox' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/echasnovski/mini.pick' },
	{ src = 'https://github.com/echasnovski/mini.pairs' },
	{ src = 'https://github.com/stevearc/conform.nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- Theme
vim.cmd('colorscheme gruvbox')
-- vim.cmd(':hi statusline guibg=NONE')
vim.cmd(':hi SignColumn guibg=NONE')

-- oil.nvim
require('oil').setup()

-- mini.pick
require('mini.pick').setup()
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')

-- mini.pairs
require('mini.pairs').setup()

-- conform.nvim
require('conform').setup({
	format_on_save = {
		lsp_format = false,
	},
	formatters_by_ft = {
		lua = { 'stylua' },
	},
})

-- mason.nvim
require('mason').setup({})

-- LSP servers
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

-- LSP settings
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
			},
		},
	},
})

-- Diagnostics
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
			[vim.diagnostic.severity.ERROR] = '󰅚 ',
			[vim.diagnostic.severity.WARN] = '󰀪 ',
			[vim.diagnostic.severity.INFO] = '󰋽 ',
			[vim.diagnostic.severity.HINT] = '󰌶 ',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.WARN] = 'WarningMsg',
		},
	},
})

-- LSP keymaps
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
