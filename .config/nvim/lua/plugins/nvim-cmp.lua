vim.pack.add({
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	'https://github.com/hrsh7th/cmp-path',
	'https://github.com/hrsh7th/cmp-buffer',
	'https://github.com/saadparwaiz1/cmp_luasnip',
	'https://github.com/L3MON4D3/LuaSnip',
})

local cmp = require('cmp')
local luasnip = require('luasnip')

luasnip.config.setup({
	history = true,
	updateevents = 'TextChanged,TextChangedI',
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),

		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{
			name = 'buffer',
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					return vim.api.nvim_buf_line_count(buf) > 5000 and {} or { buf }
				end,
			},
		},
	}),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)
			local source_names = {
				nvim_lsp = '[LSP]',
				luasnip = '[Snip]',
				buffer = '[Buf]',
				path = '[Path]',
				['vim-dadbod-completion'] = '[DB]',
			}
			vim_item.menu = source_names[entry.source.name]
				or ('[' .. entry.source.name .. ']')
			return vim_item
		end,
	},
})
