return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		views = {
			cmdline_popup = {
				position = {
					row = "15%",
					col = "50%",
				},
			},
		},
	},
	keys = {
		{ "<leader>nn", function() require("noice").cmd("history") end, desc = "Noice history" },
	},
}
