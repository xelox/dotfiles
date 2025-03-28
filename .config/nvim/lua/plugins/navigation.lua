return {
	{
		"nvim-telescope/telescope.nvim", -- Fuzzy Finder (files, lsp, etc)
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- If encountering errors, see telescope-fzf-native README for installation instructions
				build = "make",
				cond = function() -- determine whether this plugin should be
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- get pretty icons. requires a Nerd Font
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = { query = "@function.outer", desc = "Next 󰊕 Function" },
							["]c"] = { query = "@class.outer", desc = "Next 󰠱 Class" },
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next Scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next Fold" },
						},
						goto_next_end = {
							["]F"] = { query = "@function.outer", desc = "Next 󰊕 Function End" },
							["]C"] = { query = "@class.outer", desc = "Next 󰠱 Class End" },
						},
						goto_previous_start = {
							["[f"] = { query = "@function.outer", desc = "Previous 󰊕 Function Start" },
							["[c"] = { query = "@class.outer", desc = "Previous 󰠱 Class End" },
							["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous Scope" },
						},
					},
				},
				-- swap = {
				-- 	enable = true,
				-- 	swap_next = {
				-- 		["<leader>j"] = "@parameter.inner",
				-- 	},
				-- 	swap_previous = {
				-- 		["<leader>l"] = "@parameter.inner",
				-- 	},
				-- },
			})
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
	{
		"stevearc/oil.nvim", -- File system navigation
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			git = {
				mv = function(_, _)
					return true
				end,
				add = function(_)
					return true
				end,
				rm = function(_)
					return true
				end,
			},
		},
		config = function()
			-- Declare a global function to retrieve the current directory
			function _G.get_oil_winbar()
				local dir = require("oil").get_current_dir()
				if dir then
					return vim.fn.fnamemodify(dir, ":~")
				else
					-- If there is no current directory (e.g. over ssh), just show the buffer name
					return vim.api.nvim_buf_get_name(0)
				end
			end

			require("oil").setup({
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
			})
		end,
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},
}
