local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode
keymap.set("i", "jk", "<Esc>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split buffer
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

keymap.set("n", "<C-a>", "ggVG", opts)

-- Save in normal, insert, and visual modes
vim.keymap.set({ "n", "i", "v" }, "<C-s>", function()
  -- Exit insert mode if needed
  if vim.fn.mode() == "i" or vim.fn.mode() == "R" or vim.fn.mode() == "v" then
    vim.cmd("stopinsert")
  end
  -- Save buffer
  vim.cmd("w")
end, opts)
