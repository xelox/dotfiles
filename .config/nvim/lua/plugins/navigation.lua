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
			-- require("nvim-treesitter.configs").setup({
			-- 	textobjects = {
			-- 		lsp_interop = {
			-- 			enable = true,
			-- 			border = "none",
			-- 			floating_preview_opts = {},
			-- 			peek_definition_code = {
			-- 				["<leader>df"] = "@function.outer",
			-- 				["<leader>dF"] = "@class.outer",
			-- 			},
			-- 		},
			-- 	},
			-- })
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
				mv = function(src_path, dest_path)
					return true
				end,
				add = function(path)
					return true
				end,
				rm = function(path)
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
