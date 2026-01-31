vim.pack.add({
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{
		src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
})

local builtin = require('telescope.builtin')
local telescope = require('telescope')

telescope.setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			width = 0.6,
			height = 0.9,
			horizontal = {
				preview_width = 0.6,
			},
		},
		preview = { wrap = true },
	},
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'TelescopePreviewerLoaded',
	callback = function(args)
		if args.data.filetype ~= 'help' then
			vim.wo.number = true
		elseif args.data.bufname:match('*.csv') then
			vim.wo.wrap = true
		end
	end,
})

-- Load fzf-native if available
pcall(telescope.load_extension, 'fzf')

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
