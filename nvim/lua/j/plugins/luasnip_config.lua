return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- Add your graph and math snippets here
    ls.add_snippets("tex", {
      -- The Graph Theory Snippet
      s("graph", {
    t({ "\\begin{center}", "  \\begin{tikzpicture}", "    \\graph [math nodes, nodes={draw, circle}] {" , "      "}),
    i(1, "v_1 -- v_2"), 
    t({ ";", "    };", "  \\end{tikzpicture}", "\\end{center}" }),
}),

      -- Matrix for Linear Algebra Grading (3x3)
      s("mat3", {
        t({ "\\begin{bmatrix}", "  " }), 
        i(1), t(" & "), i(2), t(" & "), i(3), t({ " \\\\", "  " }),
        i(4), t(" & "), i(5), t(" & "), i(6), t({ " \\\\", "  " }),
        i(7), t(" & "), i(8), t(" & "), i(9), 
        t({ "", "\\end{bmatrix}" })
      }),
    })
  end,
}
