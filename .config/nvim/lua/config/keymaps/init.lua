local M = {}

-- Keymaps modules
local keymaps_modules = {
	'config.keymaps.general',
	'config.keymaps.navigations',
	'config.keymaps.diagnostics',
}

function M.setup()
	for _, module_path in ipairs(keymaps_modules) do
		-- Require module safely
		local loaded, keymap_module = pcall(require, module_path)

		if not loaded or type(keymap_module.setup) ~= 'function' then
			-- Notify if the module failed to load
			vim.notify(
				('Keymaps module failed to initialize: %s'):format(module_path),
				vim.log.levels.ERROR
			)
		else
			keymap_module.setup()
		end
	end
end

return M
