# Neovim Config Refactor Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Refactor the Neovim config to fix redundancies, performance bottlenecks, and a bug while splitting the monolithic `lazy.lua` into separate `options.lua` and `keymaps.lua` files for maintainability.

**Architecture:** Split `lua/config/lazy.lua` into three files (`lazy.lua`, `options.lua`, `keymaps.lua`), then fix each plugin file in-place. No new plugins are added; some dead dependencies are removed.

**Tech Stack:** Neovim (Lua), lazy.nvim, blink.cmp, nvim-lspconfig, mason.nvim, conform.nvim, telescope.nvim

---

### Task 1: Create `lua/config/options.lua`

Extract all `vim.opt` settings and leader definition out of `lazy.lua` into a dedicated file.

**Files:**
- Create: `lua/config/options.lua`

**Step 1: Create the file**

```lua
-- lua/config/options.lua
vim.g.mapleader = " "

local o = vim.opt
o.showtabline = 1
o.guicursor = ""
o.nu = true
o.relativenumber = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.showmode = false
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")
o.updatetime = 50
o.winborder = "rounded"
```

**Step 2: Verify the file reads cleanly**

Open Neovim and run `:luafile lua/config/options.lua` from the config dir. Expected: no errors.

---

### Task 2: Create `lua/config/keymaps.lua`

Extract all keymap definitions (deletions + sets) out of `lazy.lua` into a dedicated file.
The `custom_keys` table inside `lazy.setup(opts)` is wrong — lazy ignores it. Move keymaps to proper top-level execution.

**Files:**
- Create: `lua/config/keymaps.lua`

**Step 1: Create the file**

```lua
-- lua/config/keymaps.lua

-- Remove default gr* LSP keymaps added in Neovim 0.11
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank motion to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- macOS Cmd+V paste support
vim.keymap.set("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.keymap.set("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.keymap.set("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.keymap.set("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
```

Note: The `:vimgrep` keymaps (`<leader>ca` / `<leader>cr`) are intentionally dropped — they duplicate Telescope live grep (`<leader>p`) using a slower built-in Vimscript grep.

**Step 2: Verify**

Open Neovim and run `:luafile lua/config/keymaps.lua` from the config dir. Expected: no errors, keymaps active.

---

### Task 3: Rewrite `lua/config/lazy.lua`

Strip out options, keymaps, and the bogus `opts` table. Require the new files before lazy setup.

**Files:**
- Modify: `lua/config/lazy.lua`

**Step 1: Replace the file content**

```lua
-- lua/config/lazy.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keymaps")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
})
```

**Step 2: Restart Neovim**

Quit and reopen. Expected: no errors, all options and keymaps work as before.

---

### Task 4: Fix `lua/plugins/lsp.lua` — Remove dead completion deps, fix lua_ls

Three problems here:
1. `cmp-nvim-lsp` + `nvim-cmp` are loaded but `blink.cmp` is the active engine — `blink.cmp` has its own capabilities API.
2. `lspkind.nvim` is listed as a dependency with no config or integration — dead weight.
3. `lua_ls` manually adds `vim.api.nvim_get_runtime_file("", true)` to the library — this causes lua_ls to scan the entire Neovim runtime on every startup, which is a known performance issue. `lazydev.nvim` already handles this properly.

**Files:**
- Modify: `lua/plugins/lsp.lua`

**Step 1: Remove `cmp-nvim-lsp`, `nvim-cmp`, and `lspkind` from dependencies**

Remove lines 86-88 (cmp-nvim-lsp block) and line 150 (lspkind).

**Step 2: Replace capabilities source**

Change line 154:
```lua
-- Before (uses cmp-nvim-lsp):
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- After (uses blink.cmp's built-in API):
local capabilities = require("blink.cmp").get_lsp_capabilities()
```

**Step 3: Simplify the lua_ls handler**

Replace the custom `lua_ls` handler (lines 178-188) with:
```lua
["lua_ls"] = function()
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				-- lazydev.nvim handles the runtime library; only suppress the global warning
				diagnostics = { globals = { "vim" } },
			},
		},
	})
end,
```

**Step 4: Change LSP load event**

Change line 3:
```lua
-- Before:
event = "VeryLazy",

-- After:
event = { "BufReadPre", "BufNewFile" },
```

**Step 5: Restart Neovim and open a Lua file**

Expected: LSP attaches, completions work via blink.cmp, no errors in `:messages`.

---

### Task 5: Fix `lua/plugins/treesitter.lua` — Load event

Treesitter on `VeryLazy` causes a brief highlight flicker on first open because the buffer is rendered with regex highlights before treesitter loads.

**Files:**
- Modify: `lua/plugins/treesitter.lua`

**Step 1: Change load event**

Change line 3:
```lua
-- Before:
event = "VeryLazy",

-- After:
event = { "BufReadPost", "BufNewFile" },
```

**Step 2: Restart Neovim**

Open a Lua or TypeScript file. Expected: syntax highlights are correct from the first render, no flicker.

---

### Task 6: Fix `lua/plugins/oil.lua` — Remove eager loading + fix keymap typo

Two problems:
1. `lazy = false` forces Oil to load on every startup even when you never open the file tree. The `keys` table already provides lazy-loading on `<leader>m`.
2. `"<C-h"` on line 14 is missing the closing `>` — this keymap silently fails to register.

**Files:**
- Modify: `lua/plugins/oil.lua`

**Step 1: Remove `lazy = false`**

Delete line 3: `lazy = false,`

**Step 2: Fix the keymap typo**

Change line 14:
```lua
-- Before (broken):
["<C-h"] = "actions.select_split",

-- After (correct):
["<C-h>"] = "actions.select_split",
```

**Step 3: Restart Neovim**

Expected: startup is faster (Oil not loaded eagerly), `<leader>m` still opens Oil, `<C-h>` in Oil opens a horizontal split.

---

### Task 7: Commit the changes

```bash
git add lua/config/options.lua lua/config/keymaps.lua lua/config/lazy.lua \
        lua/plugins/lsp.lua lua/plugins/treesitter.lua lua/plugins/oil.lua
git commit -m "refactor: split config, fix LSP deps, load events, and oil typo

- Extract vim options to config/options.lua
- Extract keymaps to config/keymaps.lua
- Simplify config/lazy.lua (bootstrap + require only)
- Remove dead cmp-nvim-lsp/nvim-cmp/lspkind deps; use blink.cmp capabilities
- Fix lua_ls to not scan entire runtime (drop redundant library table)
- Load LSP on BufReadPre instead of VeryLazy
- Load treesitter on BufReadPost instead of VeryLazy
- Remove Oil eager loading (lazy = false)
- Fix broken <C-h keymap typo in oil.lua
- Drop slow :vimgrep keymaps (covered by Telescope live_grep)"
```

---

## Summary of All Changes

| File | Change |
|------|--------|
| `lua/config/options.lua` | NEW — vim options + mapleader |
| `lua/config/keymaps.lua` | NEW — all keymap definitions |
| `lua/config/lazy.lua` | MODIFIED — stripped to bootstrap + requires |
| `lua/plugins/lsp.lua` | MODIFIED — remove cmp/lspkind deps, fix lua_ls, fix event |
| `lua/plugins/treesitter.lua` | MODIFIED — fix load event |
| `lua/plugins/oil.lua` | MODIFIED — remove lazy=false, fix `<C-h` typo |
