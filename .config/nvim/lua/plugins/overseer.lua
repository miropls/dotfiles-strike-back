return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerToggle", "OverseerRun" },
	keys = {
		{ "<leader>ot", "<cmd>OverseerToggle right<cr>", desc = "Overseer toggle" },
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run" },
	},
	opts = {},
}
