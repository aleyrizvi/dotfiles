return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "none", -- Disable all default keymaps
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = false, -- Disabled because Copilot shows ghost text
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)

      -- Custom Tab handling: Copilot > blink.cmp > snippet > fallback
      vim.keymap.set("i", "<Tab>", function()
        -- First priority: Copilot
        local copilot_ok, copilot = pcall(require, "copilot.suggestion")
        if copilot_ok and copilot.is_visible() then
          copilot.accept()
          return
        end

        -- Second priority: blink.cmp menu
        local blink = require("blink.cmp")
        if blink.is_visible() then
          blink.select_next()
          return
        end

        -- Third priority: snippets
        if blink.snippet_active({ direction = 1 }) then
          blink.snippet_forward()
          return
        end

        -- Fallback: regular tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end, { desc = "Tab: Accept Copilot or navigate completion" })

      -- Shift-Tab for reverse navigation
      vim.keymap.set("i", "<S-Tab>", function()
        local blink = require("blink.cmp")
        if blink.is_visible() then
          blink.select_prev()
          return
        end

        if blink.snippet_active({ direction = -1 }) then
          blink.snippet_backward()
          return
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
      end, { desc = "Shift-Tab: Navigate completion backwards" })
    end,
  },
}
