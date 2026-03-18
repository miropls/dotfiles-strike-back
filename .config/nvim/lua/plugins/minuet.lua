return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "VeryLazy",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",
        n_completions = 1,
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:1.5b",
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = { "*" },
          show_on_completion_menu = true,
          keymap = {
            accept = "<Tab>",
            accept_line = "<S-Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-e>",
          },
        },
      })
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
            async = true,
            timeout_ms = 3000,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
