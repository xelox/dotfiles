vim.cmd("set nowrap")
vim.cmd("set background=dark")
vim.cmd("set ts=4")
vim.cmd("set sts=4")
vim.cmd("set sw=4")
vim.g.mapleader = " " -- Set <space> as the leader key
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true -- Show line number
vim.opt.relativenumber = true -- Enable relative line number
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.schedule(function() -- Sync clipboard between OS and Neovim.
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "↵" }
vim.opt.inccommand = "nosplit" -- Preview substitutions live, as you type!
vim.opt.cursorline = true
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

vim.api.nvim_create_autocmd("TextYankPost", { -- Blink Highlight when yanking (copying) text
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
