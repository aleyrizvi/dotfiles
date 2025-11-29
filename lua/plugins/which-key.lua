return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "Code actions" },
        { "<leader>l", group = "LSP" },
        { "<leader>f", group = "Find/File" },
        { "<leader>z", group = "Zen mode" },
        { "<leader>g", group = "Git" },
      })
    end,
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
