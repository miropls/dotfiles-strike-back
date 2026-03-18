-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Ghostty Cmd+V paste (macOS and Linux)
vim.keymap.set("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.keymap.set("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.keymap.set("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

-- LSP: hover (alongside existing K)
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Hover" })

-- LSP: type definition (overrides Neovim built-in gt = next tab)
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })

-- LSP: diagnostic float (alongside existing <leader>cd)
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Hover Diagnostic" })

-- LSP: code action (alongside existing <leader>ca)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Diagnostics: next/prev (alongside existing ]d/[d, nordic keyboard friendly)
vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev Diagnostic" })

-- LSP: rename (alongside existing <leader>cr from inc-rename extra)
vim.keymap.set("n", "<leader>rn", function()
  return ":" .. require("inc_rename").config.cmd_name .. " " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename (inc-rename.nvim)" })

-- Buffer navigation: Colemak-DH (alongside existing <S-h>/<S-l>)
vim.keymap.set("n", "<S-m>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-i>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
