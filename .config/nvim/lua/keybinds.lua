local function map(mode, l, r, d)
	vim.keymap.set(mode, l, r, { desc = d })
end

-- Removed keys
vim.keymap.set({ "n", "v" }, "s", "<Nop>")

-- QoL
map("n", "<leader>e", vim.diagnostic.open_float, "Show detailed diagnostics")
map("n", "<leader>tc", "<Cmd>TSContextToggle<CR>", "Toggle Treesitter Context")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Stop highlightig")
map("n", "<leader>q", "<cmd>bd<CR>", "Close this buffer")
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

map("n", "<left>", '<cmd>echo "Use h to move"<CR>', "Disable arrow keys navigation")
map("n", "<right>", '<cmd>echo "Use l to move"<CR>', "Disable arrow keys navigation")
map("n", "<up>", '<cmd>echo "Use k to move"<CR>', "Disable arrow keys navigation")
map("n", "<down>", '<cmd>echo "Use j to move"<CR>', "Disable arrow keys navigation")

map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", "Move focus to the left window")
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", "Move focus to the right window")
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", "Move focus to the lower window")
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", "Move focus to the upper window")
map("n", "<C-s>", "<cmd>w!<CR>", "Save")

-- Navigation
map("n", "-", "<CMD>Oil<CR>", "Open parent directory")
local builtin = require("telescope.builtin")
map("n", "<leader>fh", builtin.help_tags, "[F]ind [H]elp")
map("n", "<leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
map("n", "<leader>ff", builtin.find_files, "[F]ind [F]iles")
map("n", "<leader>fs", builtin.builtin, "[F]ind [S]elect Telescope")
map("n", "<leader>fw", builtin.grep_string, "[F]ind current [W]ord")
map("n", "<leader>fg", builtin.live_grep, "[F]ind by [G]rep")
map("n", "<leader>fr", builtin.resume, "[F]ind [R]esume")
map("n", "<leader>f.", builtin.oldfiles, '[F]ind Recent Files ("." for repeat)')
map("n", "<leader><leader>", builtin.buffers, "[F]ind existing buffers")
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, "Fuzzy current buffer")
map("n", "<leader>f/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, "[F]ind [/] in Open Files")

-- Markdown
map("n", "<leader>mdn", ":MarkdownPreview<CR>", "Start Markdown Preview")
map("n", "<leader>mdn", ":MarkdownPreviewStop<CR>", "Stop Markdown Preview")

-- Formatting
local format_fn = function()
	require("conform").format({ async = true, lsp_fallback = true })
end
map({ "n", "v" }, "<leader>=", format_fn, "Format buffer/selection")

-- Git
local gitsigns = require("gitsigns")
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle git [b]lame line")

-- Debugger
local dap = require("dap")
local dapui = require("dapui")
map("n", "<leader>d5", dap.continue, "Debug: Start/Continue F5")
map("n", "<F5>", dap.continue, "Debug: Start/Continue")

map("n", "<leader>d1", dap.step_into, "Debug: Step Into F1")
map("n", "<F1>", dap.step_into, "Debug: Step Into")

map("n", "<leader>d2", dap.step_over, "Debug: Step Over F2")
map("n", "<F2>", dap.step_over, "Debug: Step Over")

map("n", "<leader>d3", dap.step_out, "Debug: Step Into F3")
map("n", "<F3>", dap.step_out, "Debug: Step Into")

local conditional_breakpoint = function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition"))
end
map("n", "<leader>b", dap.toggle_breakpoint, "Debug: Toggle Breakpoint")
map("n", "<leader>B", conditional_breakpoint, "Debug: Set Breakpoint")

map("n", "<leader>d7", dapui.toggle, "Debug: See last session result. F7")
map("n", "<F7>", dapui.toggle, "Debug: See last session result.")
