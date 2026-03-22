return {
  {
    "CRAG666/code_runner.nvim",
    opts = {
      mode = "float",
      float = {
        close_key = "q",
        border = "rounded",
        height = 0.6,
        width = 0.6,
      },
      filetype = {
        python = "python3 -u",
        c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        javascript = "node",
        typescript = "npx ts-node",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        rust = "cd $dir && rustc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt", -- standalone files only; use cargo for projects
        go = "go run",
        lua = "lua",
        sh = "bash",
      },
    },
    keys = {
      { "<leader>r", "<cmd>RunCode<cr>", desc = "Run Code" },
    },
  },
}
