return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto",
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename", { "overseer", colored = true } },
			lualine_x = {},
			lualine_y = { "encoding", "fileformat", "filetype" },
			lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
		},
	},
}
