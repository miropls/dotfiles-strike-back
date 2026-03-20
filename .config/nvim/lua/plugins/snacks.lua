return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			enabled = true,
			sources = {
				files = { hidden = true },
				grep = { hidden = true },
			},
		},
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{
						key = "f",
						desc = "Find Files",
						action = function()
							Snacks.picker.files()
						end,
						icon = "",
					},
					{
						key = "g",
						desc = "Live Grep",
						action = function()
							Snacks.picker.grep()
						end,
						icon = "",
					},
					{
						key = "r",
						desc = "Recent Files",
						action = function()
							Snacks.picker.recent()
						end,
						icon = "",
					},
					{
						key = "c",
						desc = "Config",
						action = function()
							Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
						end,
						icon = "",
					},
					{
						key = "l",
						desc = "LazyGit",
						action = function()
							Snacks.lazygit()
						end,
						icon = "",
					},
					{
						key = "p",
						desc = "Restore Session",
						action = function()
							require("persistence").select()
						end,
						icon = "",
					},
					{
						key = "q",
						desc = "Quit",
						action = ":qa",
						icon = "",
					},
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "recent_files", limit = 5, padding = 1 },
				{ section = "startup" },
			},
		},
		animate = { enabled = true },
		scroll = { enabled = true },
		dim = { enabled = true },
		zen = { enabled = true },
		words = { enabled = true },
		toggle = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = true },
		gitbrowse = { enabled = true },
		gh = { enabled = true },
		notifier = { enabled = false },
		select = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		Snacks.toggle.zen():map("<leader>tz")
		Snacks.toggle.dim():map("<leader>td")
		Snacks.toggle.diagnostics():map("<leader>tD")
		Snacks.toggle.inlay_hints():map("<leader>ti")
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
		Snacks.toggle.option("spell", { name = "Spell" }):map("<leader>ts")
	end,
	keys = {
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
		{
			"<leader>gb",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>ghi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues",
		},
		{
			"<leader>ghp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub PRs",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Find Help Tags",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find in Config",
		},
		{
			"<leader>p",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep",
		},
		{
			"<leader>ggc",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Commits",
		},
		{
			"<leader>ggb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>ggs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>ggt",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>co",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix",
		},
	},
}
