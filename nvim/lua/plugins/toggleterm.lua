-- ToggleTerm.nvim - A neovim plugin to manage multiple terminal windows

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end,
        },
      })
      
      -- Set keymaps for terminal mode
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end
      
      -- Apply keymaps when terminal opens
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
      
      -- Create custom terminal commands
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Horizontal terminal
      local htoggle = Terminal:new({
        direction = "horizontal",
        count = 1,
      })
      
      function _HTOGGLE_TOGGLE()
        htoggle:toggle(15)
      end
      
      -- Vertical terminal
      local vtoggle = Terminal:new({
        direction = "vertical",
        count = 2,
      })
      
      function _VTOGGLE_TOGGLE()
        vtoggle:toggle(vim.o.columns * 0.4)
      end
      
      -- Float terminal
      local ftoggle = Terminal:new({
        direction = "float",
        count = 3,
      })
      
      function _FTOGGLE_TOGGLE()
        ftoggle:toggle()
      end
      
      -- Git terminal (lazygit alternative for quick commands)
      local git_terminal = Terminal:new({
        cmd = "git status && echo 'Press any key for interactive shell...' && read -n 1 && exec $SHELL",
        direction = "float",
        close_on_exit = false,
        count = 4,
      })
      
      function _GIT_TOGGLE()
        git_terminal:toggle()
      end
      
      -- Node REPL
      local node_terminal = Terminal:new({
        cmd = "node",
        direction = "horizontal",
        close_on_exit = true,
        count = 5,
      })
      
      function _NODE_TOGGLE()
        node_terminal:toggle(15)
      end
      
      -- Python REPL
      local python_terminal = Terminal:new({
        cmd = "python3",
        direction = "horizontal",
        close_on_exit = true,
        count = 6,
      })
      
      function _PYTHON_TOGGLE()
        python_terminal:toggle(15)
      end
      
      -- Terminal keymaps - using <leader><C-*> to avoid conflicts with test group
      vim.keymap.set("n", "<leader><C-h>", "<cmd>lua _HTOGGLE_TOGGLE()<CR>", { desc = "Terminal: Horizontal" })
      vim.keymap.set("n", "<leader><C-v>", "<cmd>lua _VTOGGLE_TOGGLE()<CR>", { desc = "Terminal: Vertical" })
      vim.keymap.set("n", "<leader><C-f>", "<cmd>lua _FTOGGLE_TOGGLE()<CR>", { desc = "Terminal: Float" })
      vim.keymap.set("n", "<leader><C-g>", "<cmd>lua _GIT_TOGGLE()<CR>", { desc = "Terminal: Git status" })
      vim.keymap.set("n", "<leader><C-n>", "<cmd>lua _NODE_TOGGLE()<CR>", { desc = "Terminal: Node REPL" })
      vim.keymap.set("n", "<leader><C-p>", "<cmd>lua _PYTHON_TOGGLE()<CR>", { desc = "Terminal: Python REPL" })
      
      -- Additional terminal shortcuts
      vim.keymap.set("n", "<leader><C-a>", "<cmd>ToggleTermToggleAll<CR>", { desc = "Terminal: Toggle all" })
      vim.keymap.set("n", "<leader><C-k>", "<cmd>ToggleTermKillAll<CR>", { desc = "Terminal: Kill all" })
    end,
  },
}