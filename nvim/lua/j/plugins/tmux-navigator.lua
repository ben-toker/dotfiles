return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<C-S-M-D-k>", "<cmd><C-U>TmuxNavigateLeft<cr>",  mode = { "n", "t" } },
    { "<C-S-M-D-l>", "<cmd><C-U>TmuxNavigateDown<cr>",  mode = { "n", "t" } },
    { "<C-S-M-D-o>", "<cmd><C-U>TmuxNavigateUp<cr>",    mode = { "n", "t" } },
    { "<C-S-M-D-;>", "<cmd><C-U>TmuxNavigateRight<cr>", mode = { "n", "t" } },
    { "<C-S-M-D-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", mode = { "n", "t" } },
  },
}
