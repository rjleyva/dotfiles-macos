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
vim.opt.splitbelow = true
vim.opt.cursorline = false
vim.opt.shortmess:append('WI')

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
-- Exit with 'jk'
vim.keymap.set('i', 'jk', '<ESC>')
-- Update & source
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
-- Clear search highlights
vim.keymap.set('n', '<leader>cs', vim.cmd.nohlsearch)
-- Show message history
vim.keymap.set('n', '<leader>cm', '<cmd>messages<CR>')

-- Plugins
vim.pack.add({
	{ src = 'https://github.com/vague2k/vague.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/echasnovski/mini.pick' },
	{ src = 'https://github.com/echasnovski/mini.pairs' },
	{ src = 'https://github.com/stevearc/conform.nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/SchemaStore/schemastore' },
	{ src = 'https://github.com/brenoprata10/nvim-highlight-colors' },
	{ src = 'https://github.com/kylechui/nvim-surround' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

-- Theme
vim.cmd('colorscheme vague')
-- vim.cmd(':hi statusline guibg=NONE')
vim.cmd(':hi SignColumn guibg=NONE')

-- oil.nvim
require('oil').setup()
vim.keymap.set('n', '<leader>/', ':Oil<CR>')

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

-- nvim-highlight-colors
require('nvim-highlight-colors').setup({
	render = 'virtual', -- 'background', 'foreground', 'virtual'
	enable_named_colors = true,
	enable_tailwind = true,
	enable_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_var_usage = true,
	virtual_symbol = '●',
})

-- nvim-surround
require('nvim-surround').setup({})

-- gitsigns.nvim
require('gitsigns').setup({
	signs_staged_enable = true,
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	watch_gitdir = {
		follow_files = false,
		interval = 15000,
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
	virtual_lines = true,
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
