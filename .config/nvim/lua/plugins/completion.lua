return {
	{
		"hrsh7th/nvim-cmp", -- Autocompletion
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip", -- Snippet Engine & its associated nvim-cmp source
				build = "make install_jsregexp", -- Build Step is needed for regex support in snippets.
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"hrsh7th/cmp-nvim-lsp-signature-help", -- Hints current function argument to type
			"onsails/lspkind.nvim", -- Eye candy icons based on types
			"saadparwaiz1/cmp_luasnip", -- Snippets
			"hrsh7th/cmp-nvim-lua", -- Completion for nvim lua
			"hrsh7th/cmp-buffer", -- nvim-cmp source for buffers
			"hrsh7th/cmp-cmdline", -- Completion for vim command line.
			"hrsh7th/cmp-nvim-lsp", -- lsp autocompletion
			"hrsh7th/cmp-path", -- complete paths
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			luasnip.config.setup({})

			cmp.setup({
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind_icons = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰊕",
							Constructor = "",
							Field = "󰜢",
							Variable = "󰀫",
							Class = "󰠱",
							Interface = "",
							Module = "",
							Property = "󰜢",
							Unit = "󰑭",
							Value = "󰎠",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "󰏘",
							File = "󰈙",
							Reference = "󰈇",
							Folder = "󰉋",
							EnumMember = "",
							Constant = "󰏿",
							Struct = "󰙅",
							Event = "",
							Operator = "󰆕",
							TypeParameter = "",
						}
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
							symbol_map = kind_icons, -- Override default symbols
						})(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    " .. (strings[2] or "") .. ""
						return kind
					end,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(), -- Select the [n]ext item
					["<C-k>"] = cmp.mapping.select_prev_item(), -- Select the [p]revious item

					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll the documentation window [f]orward

					["<C-c>"] = cmp.mapping.confirm({ select = true }), -- Confirm selected suggestion

					["<C-Space>"] = cmp.mapping.complete({}), -- Manually trigger completion

					["<C-l>"] = cmp.mapping(function() -- Next snippet field
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function() -- Prev snippet field
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "hrsh7th/cmp-cmdline" },
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs", -- auto close brackets, quotation marks etc.
		event = "InsertEnter",
	},
}
