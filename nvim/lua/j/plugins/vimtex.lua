return {
  {
    "lervag/vimtex",
    lazy = false,     -- Don't lazy load, load on startup
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
}

