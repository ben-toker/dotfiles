return {
  {
    "lervag/vimtex",
    lazy = false,     -- Don't lazy load, load on startup
    init = function()
      vim.g.vimtex_view_method = "Skim"
      vim.g.vimtex_quickfix_mode = 1
    end,
  },
}

