return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{ "<leader>m", "<cmd>Oil<cr>", desc = "Filetree (Oil)" },
	},
	opts = {
		columns = {
			"icon",
		},
		keymaps = {
			["q"] = "actions.close",
			["<Esc>"] = "actions.close",
			["<C-h>"] = "actions.select_split",
			["<C-v>"] = "actions.select_vsplit",
		},
		view_options = {
			show_hidden = true,
		},
		watch_for_changes = true,
		default_file_explorer = true,
	},
}
