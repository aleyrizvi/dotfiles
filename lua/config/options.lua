vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.linebreak = true
vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Disable netrw (using Snacks.nvim explorer instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Ensure write messages are shown
vim.opt.shortmess:remove("W") -- Show write messages
vim.opt.shortmess:remove("S") -- Show search count messages

-- Autocmd to show write messages
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ShowWriteMessage", { clear = true }),
  pattern = "*",
  callback = function()
    local filename = vim.fn.expand("%:t")
    local lines = vim.fn.line("$")
    vim.notify(string.format('"%s" %dL written', filename, lines), vim.log.levels.INFO)
  end,
})
