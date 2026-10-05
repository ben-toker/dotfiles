return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	config = function ()
		-- No-op for parsers that are already installed
		require("nvim-treesitter").install({
			"c", "lua", "vim", "vimdoc", "rust", "go", "cpp", "javascript", "html",
			"markdown", "markdown_inline", "yaml",
		})

		-- Highlighting and indent are no longer enabled by a setup() table;
		-- turn them on per buffer for any filetype that has a parser
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end
}
