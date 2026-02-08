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
vim.cmd([[colorscheme gruvbox]])

vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- nvim-tree binds 
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<leader>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<leader>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<leader>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<leader>l', { noremap = true, silent = true })




-- nvim-ale config
vim.cmd [[
  let g:ale_linters = {
      \ 'typescript': ['tsserver'],
      \ 'typescriptreact': ['tsserver'],
      \ }
  let g:ale_fixers = {
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ }
  let g:ale_fix_on_save = 1
]]

-- telescope binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- vimtex 
vim.g["vimtex_view_method"] = "skim"
vim.g["vimtex_view_skim_sync"] = 1
vim.g["vimtex_view_skim_activate"] = 1

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
-- remap Normal‑mode cursor keys to O‑K‑L‑; block
vim.keymap.set('n', 'o', 'k', { noremap = true, silent = true })   -- o → up
vim.keymap.set('n', 'k', 'h', { noremap = true, silent = true })   -- k → left
vim.keymap.set('n', 'l', 'j', { noremap = true, silent = true })   -- l → down
vim.keymap.set('n', ';', 'l', { noremap = true, silent = true })   -- ; → right

-- (optional) mirror in Visual mode if you want selection movement too
vim.keymap.set('v', 'o', 'k', { noremap = true, silent = true })
vim.keymap.set('v', 'k', 'h', { noremap = true, silent = true })
vim.keymap.set('v', 'l', 'j', { noremap = true, silent = true })
vim.keymap.set('v', ';', 'l', { noremap = true, silent = true })

