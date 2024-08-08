require("dap").listeners.after.event_initialized["dapui_config"] = function()
	require("dapui").open()
end

require("dap").listeners.before.event_terminated["dapui_config"] = function()
	require("dapui").close()
end

require("dap").listeners.before.event_exited["dapui_config"] = function()
	require("dapui").close()
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
require("dap").listeners.after["event_initialized"]["dap-virtual-text"] = function()
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
require("dap").adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode-14", -- adjust as needed, must be absolute path
	name = "lldb",
}

require("dap").configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		console = "integratedTerminal",
		program = function()
			local p = vim.fn.expand("%:p:h")
			---@diagnostic disable-next-line: redundant-parameter
			-- return vim.fn.input("Path to executable: ", p .. "/", "file")
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		-- NOTE: If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--  set it to 1 after you finished
		name = "Attach to process",
		type = "lldb",
		request = "attach",
		console = "integratedTerminal",
		pid = require("dap.utils").pick_process,
		args = {},
	},
}
require("dap").configurations.c = require("dap").configurations.cpp
require("dap").configurations.rust = require("dap").configurations.cpp

-- Load nvim-dap configuration for Go
require("dap").adapters.go = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/go/bin/dlv" },
}
-- use dap-go, or you can provide your own configurations

-- TODO: copy configs from lazy vim site.
require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

local exts = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

for _, ext in ipairs(exts) do
	require("dap").configurations[ext] = {
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
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "node",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with ts-node)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "--loader", "ts-node/esm" },
			runtimeExecutable = "node",
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
				"${workspaceFolder}/**",
				"!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with vitest)",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Program (pwa-chrome)",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = function()
				return tonumber(vim.fn.input("PORT: "))
			end,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "node2",
			request = "attach",
			name = "Attach Program (Node2)",
			processId = require("dap.utils").pick_process,
		},
		{
			type = "node2",
			request = "attach",
			name = "Attach Program (Node2 with ts-node)",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			skipFiles = { "<node_internals>/**" },
			port = 9229,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach Program (pwa-node)",
			cwd = vim.fn.getcwd(),
			-- cwd = "$workspaceFolder",
			processId = require("dap.utils").pick_process,
			skipFiles = { "<node_internals>/**" },
			sourceMaps = true,
		},
	}
end
