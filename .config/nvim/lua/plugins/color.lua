return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			transparent = true,
			overrides = function()
				return {
					SignColumn = { bg = "none" },
					LineNr = { bg = "none" },
					LineNrAbove = { bg = "none" },
					LineNrBelow = { bg = "none" },
					DiagnosticSignError = { bg = "none" },
					DiagnosticSignWarn = { bg = "none" },
					DiagnosticSignInfo = { bg = "none" },
					DiagnosticSignHint = { bg = "none" },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa-dragon")
	end,
}
