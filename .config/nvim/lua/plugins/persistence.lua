return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>ss",
			function()
				require("persistence").select()
			end,
			desc = "Restore session",
		},
		{
			"<leader>sl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>sd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save session",
		},
	},
}
