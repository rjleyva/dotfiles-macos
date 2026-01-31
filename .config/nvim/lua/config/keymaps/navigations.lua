local M = {}

function M.setup()
	-- Set keymaps once
	if M.keymaps_initialized then
		return
	end

	M.keymaps_initialized = true

	-- Move cursor
	local function move_cursor(direction)
		vim.cmd('wincmd ' .. direction)
	end

	-- Bind a key combination to movement direction
	local function bind_key(key_combination, direction)
		vim.keymap.set('n', key_combination, function()
			move_cursor(direction)
		end)
	end

	-- Split navigation keymaps
	bind_key('<C-h>', 'h')
	bind_key('<C-j>', 'j')
	bind_key('<C-k>', 'k')
	bind_key('<C-l>', 'l')
end

return M
