return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- Creates a beautiful debugger UI
		"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
		"williamboman/mason.nvim", -- Installs the debug adapters for you
		"jay-babu/mason-nvim-dap.nvim", -- Installs the debug adapters for you
		"leoluz/nvim-dap-go", -- Debugging for Go
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true, -- Makes a best effort to setup the various debuggers with
			handlers = {}, -- see mason-nvim-dap README for more information
			ensure_installed = {
				"delve",
				"cpptools",
				"codelldb",
			},
		})

		-- Dap UI setup
		---@diagnostic disable-next-line: missing-fields
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			---@diagnostic disable-next-line: missing-fields
			controls = {
				enabled = true,
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "",
					terminate = "",
					disconnect = "",
				},
			},
		})
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install golang specific config
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
			},
		})
		dap.configurations.cppdbg = {
			{
				name = "Launch",
				type = "cpptools",
				request = "launch",
				program = "${workspaceFolder}/main",
				cwd = "${workspaceFolder}",
				stopOnEntry = true,
				args = {},
				runInTerminal = false,
			},
		}
		dap.configurations.zig = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
				command = "zig builld",
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
	end,
}
