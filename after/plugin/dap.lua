local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
local dap_python_path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
local dap_go = require("dap-go")
require("nvim-dap-virtual-text").setup()

-- TODO: setup dap and daupi
-- TODO: patch dap-ui icons

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap_python.setup(dap_python_path)
dap_go.setup()
