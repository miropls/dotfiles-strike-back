return {
	"stevearc/overseer.nvim",
	cmd = { "OverseerToggle", "OverseerRun", "OverseerList" },
	keys = {
		{ "<leader>ot", "<cmd>OverseerToggle right<cr>", desc = "Overseer toggle" },
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer run" },
	},
	opts = {},
}
