return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>gsp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
		{ "<leader>gsi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk inline" },
		{ "<leader>gss", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
	},
	opts = {
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text_pos = "eol",
		},
	},
}
