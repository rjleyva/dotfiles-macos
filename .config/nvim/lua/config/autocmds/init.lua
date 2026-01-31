local M = {}

-- Autocmd modules
local autocmd_modules = {
	'config.autocmds.highlight_yank',
	'config.autocmds.text_wrap_spell',
}

function M.setup()
	for _, module_path in ipairs(autocmd_modules) do
		-- Require module safely
		local loaded, autocmd_module = pcall(require, module_path)

		if not loaded or type(autocmd_module.setup) ~= 'function' then
			-- Notify if the module failed to load
			vim.notify(
				('Autocmd module failed to initialize: %s'):format(module_path),
				vim.log.levels.ERROR
			)
		else
			autocmd_module.setup()
		end
	end
end

return M
