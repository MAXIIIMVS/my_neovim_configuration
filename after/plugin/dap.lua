local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

-- Setup nvim-virtual-text
require("nvim-dap-virtual-text").setup({
	highlight = "DiagnosticVirtualTextError",
	prefix = " ",
	spacing = 2,
	severity_limit = "error",
	virtual_text = true,
})

-- Setup nvim-dap virtual text
dap.listeners.after["event_initialized"]["dap-virtual-text"] = function()
	vim.fn.sign_define(
		"DapVirtualTextError",
		{ text = " ", texthl = "DiagnosticVirtualTextError", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapVirtualTextWarning",
		{ text = " ", texthl = "DiagnosticVirtualTextWarning", linehl = "", numhl = "" }
	)
end

-- Load nvim-dap configuration for C/C++
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode-14", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			local p = vim.fn.expand("%:p:h")
			---@diagnostic disable-next-line: redundant-parameter
			return vim.fn.input("Path to executable: ", p .. "/", "file")
			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}
dap.configurations.c = dap.configurations.cpp

-- Load nvim-dap configuration for JavaScript and TypeScript
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		-- 💀 Make sure to update this path to point to your installation
		args = {
			os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}
dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		runtimeExecutable = "deno",
		runtimeArgs = {
			"run",
			"--inspect-wait",
			"--allow-all",
		},
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 9229,
	},
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = {
		os.getenv("HOME") .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
	},
}

dap.configurations.typescriptreact = {
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		-- url = "http://localhost:5173",
		url = function()
			local port = vim.fn.input("PORT: ")
			return "http://localhost:" .. port
		end,
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/opt/firefox/firefox-bin",
	},
}

dap.configurations.javascriptreact = dap.configurations.typescriptreact

-- Load nvim-dap configuration for Go
dap.adapters.go = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/go/bin/dlv" },
}
-- use dap-go, or you can provide your own configurations

-- Load nvim-dap configuration for Python
require("dap-python").setup(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- TODO: configure rust and lua
