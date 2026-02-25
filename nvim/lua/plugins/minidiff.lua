-- Mini.diff - Minimal Git signs integration
-- Works well with Snacks.nvim statuscolumn

return {
  {
    "echasnovski/mini.diff",
    version = "*",
    opts = {
      -- Appearance of signs
      view = {
        -- Visualization style. Possible values are 'sign' and 'number'.
        style = "sign",
        -- Signs used for hunks with 'sign' view
        signs = {
          add = "▎",
          change = "▎", 
          delete = "▁",
        },
        -- Priority of used visualization extmarks
        priority = 199,
      },
      
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Apply hunks inside a visual/operator region
        apply = "gh",
        -- Reset hunks inside a visual/operator region  
        reset = "gH",
        -- Hunk range textobject to be used inside operator
        -- Works also in Visual mode if mapping differs from apply and reset
        textobject = "gh",
        -- Go to hunk range in corresponding direction
        goto_first = "[H",
        goto_prev = "[h", 
        goto_next = "]h",
        goto_last = "]H",
      },
      
      -- Options for hunks
      options = {
        -- Diff algorithm. See `:h vim.diff()`.
        algorithm = "histogram",
        -- Whether to use "indent heuristic". See `:h vim.diff()`.
        indent_heuristic = true,
        -- The amount of second-stage diff to run on hunks for more granular
        -- diff. Should be at least 1 to have consistent behavior.
        linematch = 60,
        -- Whether to wrap around edges during hunk navigation
        wrap_goto = false,
      },
    },
    
    config = function(_, opts)
      require("mini.diff").setup(opts)
      
      -- Additional keymaps that integrate with your <leader>g* Git group
      vim.keymap.set("n", "<leader>gho", function()
        require("mini.diff").toggle_overlay(0)
      end, { desc = "Git: Toggle diff overlay" })
      
      vim.keymap.set("n", "<leader>ghs", function()
        require("mini.diff").operator("apply")
      end, { desc = "Git: Stage operator" })
      
      vim.keymap.set("n", "<leader>ghr", function()
        require("mini.diff").operator("reset") 
      end, { desc = "Git: Reset operator" })
      
      vim.keymap.set("n", "<leader>ghd", function()
        local buf_id = vim.api.nvim_get_current_buf()
        require("mini.diff").set_ref_text(buf_id, "HEAD")
      end, { desc = "Git: Set diff reference to HEAD" })
    end,
  },
}