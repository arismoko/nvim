return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = { "select_and_accept", "fallback" }
      opts.keymap["<C-d>"] = { "select_next", "fallback" }
      opts.keymap["<C-u>"] = { "select_prev", "fallback" }

      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer", "copilot_chat" }
      -- copilot_chat source self-filters to CopilotChat buffers only

      -- Configure CopilotChat sources for chat buffers and the edit overlay
      opts.sources.per_filetype = {
        ["copilot-chat"] = { "copilot_chat" },
        markdown = function()
          if vim.b.copilot_chat_prompt then
            return { "copilot_chat", inherit_defaults = false }
          end
          return { inherit_defaults = true }
        end,
      }

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.copilot_chat = {
        name = "copilot_chat",
        module = "CopilotChat.integrations.blink",
        score_offset = 100,
        async = true,
      }

      return opts
    end,
  },
}
