vim.g.mapleader = ' '



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("j.plugins")

vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox-material]])
vim.cmd([[colorscheme monokai-pro]])

vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

--general binds

-- Normal mode: Toggle comment for the current line
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment line' })

-- Visual mode: Toggle comment for the selected block
--
vim.keymap.set('v', '<C-/>', 'gc', { remap = true, desc = 'Toggle comment block' }) -- nvim-tree binds
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- terminal-mode escape so window-nav keys work from a :terminal buffer
vim.keymap.set('t', '<C-\\><C-n>', [[<C-\><C-n>]])

-- auto-enter insert mode when focusing a terminal window
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufWinEnter', 'WinEnter' }, {
  pattern = 'term://*',
  command = 'startinsert',
})





-- telescope binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.schedule(function()
      -- Force the underscore to be a 'Label' (neutral color) inside TikZ
      vim.cmd([[syntax match texSpecialChar /_/ containedin=texTikzZone]])

      -- Specifically tell the error engine to ignore underscores in this zone
      vim.cmd([[syntax cluster texErrorGroup add=texSpecialChar]])

      -- Restore general error highlighting that 'tex_no_error' might have killed
      vim.cmd([[highlight link texError Error]])
    end)
  end,
})
-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

vim.diagnostic.config({
  virtual_text = true,
  underline = false,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = true },
})

-- give float windows a distinct background so they stand out from the terminal
local function style_floats()
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#3a3741' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#3a3741', fg = '#a9a1b3' })
  vim.api.nvim_set_hl(0, 'FloatTitle',  { bg = '#3a3741', fg = '#ffd866' })
end
style_floats()
vim.api.nvim_create_autocmd('ColorScheme', { callback = style_floats })

-- show diagnostic float when the cursor rests on an error line
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
  end,
})

-- cargo as the :make program for Rust buffers (used by :Make test / :Make clippy)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.cmd('compiler cargo')
  end,
})

-- remap Normal‑mode cursor keys to O‑K‑L‑; block
vim.keymap.set('n', 'o', 'k', { noremap = true, silent = true }) -- o → up
vim.keymap.set('n', 'k', 'h', { noremap = true, silent = true }) -- k → left
vim.keymap.set('n', 'l', 'j', { noremap = true, silent = true }) -- l → down
vim.keymap.set('n', ';', 'l', { noremap = true, silent = true }) -- ; → right

-- (optional) mirror in Visual mode if you want selection movement too
vim.keymap.set('v', 'o', 'k', { noremap = true, silent = true })
vim.keymap.set('v', 'k', 'h', { noremap = true, silent = true })
vim.keymap.set('v', 'l', 'j', { noremap = true, silent = true })
vim.keymap.set('v', ';', 'l', { noremap = true, silent = true })
