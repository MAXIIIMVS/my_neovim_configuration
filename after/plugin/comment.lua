---@diagnostic disable: missing-fields
require("Comment").setup({
	toggler = {
		line = "<C-_>",
	},
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
