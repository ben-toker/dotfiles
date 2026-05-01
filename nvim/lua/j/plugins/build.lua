return {
  {
    'tpope/vim-dispatch',
    cmd = { 'Make', 'Dispatch', 'Start', 'Focus', 'Copen' },
    keys = {
      { '<leader>ct', '<cmd>Make! test<cr>',   desc = 'Cargo test (background)' },
      { '<leader>cl', '<cmd>Make! clippy<cr>', desc = 'Cargo clippy (background)' },
      { '<leader>co', '<cmd>Copen<cr>',        desc = 'Open quickfix (last build)' },
    },
  },
}
