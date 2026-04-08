return {
  {
    "lervag/vimtex",
    lazy = false,     -- Don't lazy load, load on startup
    init = function()
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "/opt/homebrew/bin/zathura"
      vim.g.vimtex_quickfix_mode = 1
      vim.g.vimtex_quickfix_ignore_filters = {
        'Warning',
        'Underfull',
        'Overfull',
      }
    end,
  },
}

