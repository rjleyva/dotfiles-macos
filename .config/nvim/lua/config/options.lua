local M = {}

function M.leader()
	vim.g.mapleader = ' '
	vim.g.mouse = ''
end

function M.ui()
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.wrap = false
	vim.opt.termguicolors = true
	vim.opt.laststatus = 1
	vim.opt.conceallevel = 0
	vim.opt.signcolumn = 'yes:1'
	vim.opt.scrolloff = 8
	vim.opt.termguicolors = true
	vim.opt.tabstop = 2
	vim.opt.winborder = 'rounded'
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.smartindent = true
	vim.opt.tabstop = 2
end

function M.behavior()
	vim.opt.list = false
	vim.opt.spelllang = { 'en' }
	vim.opt.splitright = true
	vim.opt.splitbelow = true
end

function M.search()
	vim.opt.hlsearch = true
	vim.opt.ignorecase = true
	vim.opt.inccommand = 'split'
	vim.opt.smartcase = true
end

function M.shell()
	vim.opt.shell = vim.env.SHELL or 'zsh'
	vim.opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
	vim.opt.completeopt = 'menu,menuone,noselect'
end

function M.misc()
	vim.opt.formatoptions:append('r')
	vim.opt.path:append('**')
	vim.opt.wildignore:append('*/node_modules/*')
	vim.opt.wildmode = 'longest:full,full'
	vim.opt.backspace = { 'start', 'eol', 'indent' }
	vim.opt.backup = false
	vim.opt.swapfile = false
	vim.opt.shortmess:append('WI')
	vim.g.deprecation_warnings = true
end

function M.setup()
	M.leader()
	M.ui()
	M.behavior()
	M.search()
	M.shell()
	M.misc()
end

return M
