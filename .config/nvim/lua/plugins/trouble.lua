return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {},
	keys = {
		{ "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
		{ "<leader>dw", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics" },
	},
}
