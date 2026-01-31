local M = {}

function M.setup()
	-- Populate the quickfix list with current diagnostics
	vim.keymap.set('n', '<leader>xq', vim.diagnostic.setqflist)

	-- Populate the location list with current diagnostics
	vim.keymap.set('n', '<leader>xl', vim.diagnostic.setloclist)

	-- Toggle virtual text display for diagnostics on/off
	vim.keymap.set('n', '<leader>xt', function()
		local current_status = vim.diagnostic.config().virtual_text
		vim.diagnostic.config({ virtual_text = not current_status })
		--  Enable `vim.notify` if you want a status message.
		-- vim.notify(
		-- 	'Diagnostics virtual text: ' .. (current_status and 'OFF' or 'ON')
		-- )
	end)
end

return M
