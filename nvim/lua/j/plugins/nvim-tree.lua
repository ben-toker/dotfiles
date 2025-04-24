
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw in favor of nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- enable true color support
    vim.opt.termguicolors = true

    -- define on_attach to remove the default "o" mapping
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")
      -- load all default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- remove the "o" → Open binding so your global "o" can take effect
      vim.keymap.del("n", "o", { buffer = bufnr })
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            git          = true,
            file         = false,
            folder       = false,
            folder_arrow = true,
          },
          glyphs = {
            folder = {
              arrow_closed = "⏵",
              arrow_open   = "⏷",
            },
            git = {
              unstaged  = "✗",
              staged    = "✓",
              unmerged  = "⌥",
              renamed   = "➜",
              untracked = "★",
              deleted   = "⊖",
              ignored   = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = true,
      },
    })
  end,
}

