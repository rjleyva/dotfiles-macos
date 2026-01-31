local M = {}

function M.setup()
	-- Exit insert mode with 'jk'
	vim.keymap.set('i', 'jk', '<ESC>')

	-- Increment & Decrement
	vim.keymap.set('n', '<leader>+', '<C-a>')
	vim.keymap.set('n', '<leader>-', '<C-x>')

	-- Clear search highlights
	vim.keymap.set('n', '<leader>cs', vim.cmd.nohlsearch)

	-- Source current file & update
	vim.keymap.set('n', '<leader>us', ':update<CR> :source<CR>')
end

return M
