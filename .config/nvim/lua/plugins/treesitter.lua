-- REMEMBER: Install the tree-sitter-cli
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    require("nvim-treesitter").install({
      "c",
      "lua",
      "rust",
      "go",
      "vimdoc",
      "astro",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "php",
      "bash",
      "query",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c",
        "lua",
        "rust",
        "go",
        "javascript",
        "typescript",
        "html",
        "yaml",
        "typescriptreact",
        "php",
        "sh",
        "astro",
        "help",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    require("treesitter-context").setup({
      enable = true,
      line_numbers = true,
      max_lines = 1,
    })
  end,
}
