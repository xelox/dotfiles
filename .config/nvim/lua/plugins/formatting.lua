return {
	{
		"lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank lines
		main = "ibl",
		opts = {},
	},
	{
		"stevearc/conform.nvim", -- Autoformat
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
}
