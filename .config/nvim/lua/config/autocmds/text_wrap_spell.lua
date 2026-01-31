local M = {}

function M.setup()
	-- Enable wrap and spellcheck for text-like files
	vim.api.nvim_create_autocmd('FileType', {
		pattern = {
			'text',
			'plaintext',
			'typst',
			'gitcommit',
			'markdown',
		},

		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})
end

return M
