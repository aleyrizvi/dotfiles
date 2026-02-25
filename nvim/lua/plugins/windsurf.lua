return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_no_map_tab = 1

      -- Accept Codeium suggestion with aA in insert mode
      vim.keymap.set("i", "aA", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })

      -- Cycle through suggestions
      vim.keymap.set("i", "<M-]>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true, desc = "Next Codeium suggestion" })

      vim.keymap.set("i", "<M-[>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })

      -- Clear suggestion
      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })

      -- Open Codeium Chat (normal mode)
      vim.keymap.set("n", "<leader>ac", function()
        return vim.fn["codeium#Chat"]()
      end, { expr = true, silent = true, desc = "Open Codeium Chat" })
    end,
  },
}
