local M = {}

M.spec = {
	'mistweaverco/kulala.nvim',
	ft = { 'http', 'rest' },
	lazy = true,

	init = function()
		vim.filetype.add({
			extension = {
				http = 'http',
				rest = 'http',
			},
		})
	end,

	opts = {
		global_keymaps = false,
		global_keymaps_prefix = '<leader>R',
		kulala_keymaps_prefix = '',
	},

	config = function(_, opts)
		local status_ok, kulala = pcall(require, 'kulala')
		if not status_ok then
			vim.notify('[kulala.nvim] failed to load', vim.log.levels.ERROR)
			return
		end

		kulala.setup(opts)

		-- helper function to register keymaps
		local function map(lhs, fn_name, desc)
			vim.keymap.set('n', lhs, function()
				require('kulala')[fn_name]()
			end, { desc = desc, noremap = true, silent = true })
		end

		-- Kulala keymaps
		map('<leader>rs', 'run', 'Send request under cursor')
		map('<leader>ra', 'run_all', 'Send all requests in file')
		map('<leader>rb', 'open_scratchpad', 'Open kulala scratchpad')
	end,
}

return M.spec
