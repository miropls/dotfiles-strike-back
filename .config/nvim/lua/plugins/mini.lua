return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy", -- Lazy-load the entire mini.nvim suite
  config = function()
    -- Appereance
    require("mini.icons").setup()

    -- Text manipulation
    require("mini.ai").setup()
    require("mini.operators").setup({
      evaluate = { prefix = "m=" },
      exchange = { prefix = "mx", reindent_linewise = true },
      multiply = { prefix = "mm" },
      replace = { prefix = "mr", reindent_linewise = true },
      sort = { prefix = "ms" },
    })
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.align").setup({
      mappings = { start = "ma", start_with_preview = "mA" },
    })
    require("mini.splitjoin").setup({
      mappings = { toggle = "mS" },
    })

    require("mini.move").setup({
      mappings = {
        left = "<M-Left>",
        down = "<M-Down>",
        up = "<M-Up>",
        right = "<M-Right>",
        line_left = "<M-Left>",
        line_down = "<M-Down>",
        line_up = "<M-Up>",
        line_right = "<M-Right>",
      },
    })

    -- require("mini.diff").setup()

    -- Navigation
    require("mini.bracketed").setup()

    -- Appearance
    require("mini.hipatterns").setup({
      highlighters = {
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
      },
    })
  end,
}
