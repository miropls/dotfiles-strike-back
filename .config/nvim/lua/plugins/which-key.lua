return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 500,
		spec = {
			{ "<leader>a", group = "AI" },
			{ "<leader>d", group = "Diagnostics" },
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>gg", group = "Git Pickers" },
			{ "<leader>gh", group = "GitHub" },
			{ "<leader>gs", group = "GitSigns" },
			{ "<leader>h", group = "Harpoon" },
			{ "<leader>l", group = "Lazy" },
			{ "<leader>m", group = "Filetree" },
			{ "<leader>n", group = "LSP" },
			{ "<leader>o", group = "Overseer" },
			{ "<leader>r", group = "Rename" },
			{ "<leader>t", group = "Toggle" },
		},
	},
}
