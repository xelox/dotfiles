return {

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()
			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ebugger" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>f", group = "[F]ind" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			multiline_threshold = 1,
			trim_scope = "inner",
		},
		enabled = true,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		modes = {
			preview_float = {
				mode = "diagnostics",
				preview = {
					type = "float",
					relative = "editor",
					border = "rounded",
					title = "Preview",
					title_pos = "center",
					position = { 0, -2 },
					size = { width = 0.3, height = 0.3 },
					zindex = 200,
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 }) -- Better Around/Inside textobjects
			require("mini.surround").setup() -- Add/delete/replace surroundings (brackets, quotes, etc.)
		end,
	},
	{
		"Wansmer/treesj", -- Merge/split list items
		keys = { "<space>m" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim", -- Markdown Preview
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app; yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_browser = "/Applications/Brave Browser.app"
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim", -- Render markdown inside of neovim
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		opts = {
			heading = {
				icons = {},
			},
			html = {
				comment = {
					conceal = false,
				},
			},
			render_modes = true,
		},
	},
	{
		"rmagatti/auto-session", -- Automatically open buffers from last sessions.
		lazy = false,
		cmd = { "SessionRestore", "SessionSave" },
		config = function()
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/dev", "~/Downloads", "/" },
			})
		end,
	},
	{
		"vhyrro/luarocks.nvim", -- Dependency for image.nvim
		priority = 1001, -- needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"3rd/image.nvim", -- Render images in the terminal
		dependencies = { "luarocks.nvim" },
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("image").setup({
				integrations = {
					markdown = {
						only_render_image_at_cursor = false,
						filetypes = { "markdown" },
					},
				},
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
				editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
			})
		end,
	},
}
