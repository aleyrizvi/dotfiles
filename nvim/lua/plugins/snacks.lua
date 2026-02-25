return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- Show marks and signs (including git)
        right = { "fold", "git" }, -- Show git indicators on the right
      },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      input = {},
      git = { enabled = true },
      gitbrowse = { enabled = true },
      explorer = {
        enabled = true,
        replace_netrw = true,
        win = {
          width = 30,
          style = "minimal",
        },
      },
      dashboard = {},
      scroll = {},
      indent = {},
      zen = {
        toggles = {},
      },
      picker = {},
    },
    keys = {
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers({
            win = {
              input = {
                keys = {
                  ["dd"] = "bufdelete",
                  ["<c-d>"] = {
                    "bufdelete",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          })
        end,
        desc = "Buffers",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Find using grep()",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Recent",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>fw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "grep word",
      },
      {
        "<leader>go",
        function()
          Snacks.gitbrowse.open()
        end,
        desc = "Git Browse Open",
      },
      {
        "<leader>e",
        function()
          local ok, err = pcall(function()
            Snacks.explorer()
          end)
          if not ok then
            vim.notify("Explorer error: " .. tostring(err), vim.log.levels.ERROR)
            -- Fallback to netrw if Snacks explorer fails
            vim.cmd("Explore")
          end
        end,
        desc = "File Explorer",
      },
      {
        "<leader>zz",
        function()
          Snacks.zen()
        end,
        desc = "Toggle zen mode",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      -- git
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },

      -- File operations
      {
        "<leader>fn",
        function()
          local filename = vim.fn.input("New file: ", "", "file")
          if filename ~= "" then
            vim.cmd("edit " .. filename)
          end
        end,
        desc = "New File",
      },
      -- code
      {
        "<leader>cd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>cD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      -- lsp keys
      -- LSP
      {
        "<leader>ld",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "<leader>lD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "<leader>lr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "<leader>li",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "<leader>lt",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>lai",
        function()
          Snacks.picker.lsp_incoming_calls()
        end,
        desc = "C[a]lls Incoming",
      },
      {
        "<leader>lao",
        function()
          Snacks.picker.lsp_outgoing_calls()
        end,
        desc = "C[a]lls Outgoing",
      },
      {
        "<leader>ls",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
    },
  },
}
