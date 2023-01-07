local home = os.getenv("HOME")
local wk = require("which-key")

require("mind").setup({
	persistence = {
		state_path = home .. "/notes/mind/mind.json",
		data_dir = home .. "/notes/mind/data",
	},
	ui = {
		width = 40,
		highlight = {
			node_root = "Number",
		},
	},

	keymaps = {
		normal = {
			T = function(args)
				require("mind.ui").with_cursor(function(line)
					local tree = args.get_tree()
					local node = require("mind.node").get_node_by_line(tree, line)

					if node.icon == nil or node.icon == " " then
						node.icon = " "
					elseif node.icon == " " then
						node.icon = " "
					end
					args.save_tree()
					require("mind.ui").rerender(tree, args.opts)
				end)
			end,
		},
	},
})

wk.register({
	o = {
		name = "Org Mode (Mind)",
		o = { "<cmd>MindOpenMain<CR>", "Open the main Mind tree" },
		p = { "<cmd>MindOpenProject<CR>", "Open the project tree" },
		c = { "<cmd>MindClose<CR>", "Close project or main mind tree if open" },
		r = { "<cmd>MindReloadState<CR>", "Reload Mind state for global and local trees" },
		s = {
			"<cmd>MindOpenSmartProject<CR>",
			"Open the project tree, either local, global or prompt the user for which kind of project tree to create",
		},
	},
}, { prefix = "<space>", noremap = true, silent = true, nowait = true })

wk.register({
	[";"] = {
		m = { "<cmd>MindOpenMain<CR>", "Open the main Mind tree" },
	},
}, { prefix = "", noremap = true, silent = true, nowait = true })
