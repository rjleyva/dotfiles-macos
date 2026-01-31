local M = {}

function M.setup()
	-- Highlight yanked text briefly
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.hl.on_yank({ timeout = 150 })
		end,
	})
end

return M
