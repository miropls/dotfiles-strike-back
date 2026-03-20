return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	keys = {
		{
			"gh",
			function()
				vim.lsp.buf.hover({ max_width = math.floor(vim.o.columns * 0.8) })
			end,
			desc = "Hover",
		},
		{ "gl", vim.diagnostic.open_float, desc = "Hover error" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto declaration" },
		{ "ga", vim.lsp.buf.code_action, desc = "Code actions" },
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
		{ "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type definition" },
		{ "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
		{ "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto implementations" },
		{
			"<leader>dn",
			function()
				vim.diagnostic.jump({ count = 1, float = true })
			end,
			desc = "Go to next diagnostic",
		},
		{
			"<leader>dp",
			function()
				vim.diagnostic.jump({ count = -1, float = true })
			end,
			desc = "Go to prev diagnostic",
		},
		{ "<leader>ni", "<cmd>LspInfo<CR>", desc = "LspInfo" },
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			},
		},
		"mason-org/mason-lspconfig.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
		},
		{ "windwp/nvim-ts-autotag", event = "VeryLazy", config = true },
		{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
		{
			"saghen/blink.cmp",
			event = "InsertEnter",
			dependencies = "rafamadriz/friendly-snippets",
			version = "1.*",
			opts = function()
				return {
					keymap = { preset = "enter" },
					cmdline = {
						keymap = {
							preset = "enter",
							["<Tab>"] = {
								function(cmp)
									if not cmp.is_menu_visible() then
										cmp.show()
									else
										cmp.select_next()
									end
								end,
							},
							["<S-Tab>"] = {
								function(cmp)
									if not cmp.is_menu_visible() then
										cmp.show()
									else
										cmp.select_prev()
									end
								end,
							},
						},
					},
					appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono" },
					sources = {
						default = { "lsp", "path", "snippets", "buffer", "lazydev" },
						providers = {
							lsp = { fallbacks = { "lazydev" } },
							lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
						},
						min_keyword_length = function(ctx)
							if ctx.mode == "cmdline" then
								return 6
							end
							return 0
						end,
					},
					completion = {
						accept = { auto_brackets = { enabled = true } },
						documentation = { auto_show = true, auto_show_delay_ms = 0 },
						list = { selection = { preselect = true, auto_insert = false } },
					},
					signature = { enabled = true },
				}
			end,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"clangd",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"eslint",
				"gopls",
				"intelephense",
				"jsonls",
				"lua_ls",
				"rust_analyzer",
				"tailwindcss",
				"vtsls",
				"vimls",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								-- lazydev.nvim handles the runtime library
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,
			},
		})
	end,
}
