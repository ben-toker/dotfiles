

return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local i = ls.insert_node
    local f = ls.function_node


  local function gen_bipartite(args)
    local m = tonumber(args[1][1]) or 1
    local n = tonumber(args[2][1]) or 1
    
    local v_list = {}
    local w_list = {}
    
    for j = 1, m do table.insert(v_list, "v_" .. j) end
    for j = 1, n do table.insert(w_list, "u_" .. j) end
    
    local v_str = "{" .. table.concat(v_list, ", ") .. "}"
    local w_str = "{" .. table.concat(w_list, ", ") .. "}"
    
    -- Returns the vertex lists for the subgraph and the connection line
    return v_str .. " -- " .. w_str .. ";"
end


    -- Add your graph and math snippets here
    ls.add_snippets("tex", {
      -- The Graph Theory Snippet
      s("graph", {
    t({ "\\begin{center}", "  \\begin{tikzpicture}", "    \\graph [math nodes, nodes={draw, circle}] {" , "      "}),
    i(1, "v_1 -- v_2"), 
    t({ ";", "    };", "  \\end{tikzpicture}", "\\end{center}" }),
}),

-- Complete Bipartite Graph Snippet (K_m,n)
 s("kmn", {
    t({ "\\begin{center}", "  \\begin{tikzpicture}", "    \\graph [math nodes, nodes={draw, circle}, " }),
    t("grow right="), i(5, "3cm"), t(", branch down="), i(6, "1.2cm"),
    t({ "] {", "      subgraph K_nm [n=" }),
    i(1, "3"), t(", m="), i(2, "3"), 
    t(", V={"), i(3, "a"), t("_1, "), f(function(args) return args[1][1] end, {3}), t("_2, "), f(function(args) return args[1][1] end, {3}), t("_3"),
    t("}, W={"), i(4, "b"), t("_1, "), f(function(args) return args[1][1] end, {4}), t("_2, "), f(function(args) return args[1][1] end, {4}), t("_3"),
    t({ "}];", "    };", "  \\end{tikzpicture}", "\\end{center}" }),
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
