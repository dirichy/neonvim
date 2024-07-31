-- [
-- snip_env + autosnippets
-- ]
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- [
-- personal imports
-- ]
local tex =require("latex.conditions.luasnip")

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(args, snip)
  local rows = snip.captures[2] and tonumber(snip.captures[2]) or 2
  local cols = snip.captures[3] and tonumber(snip.captures[3]) or rows
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t("\\\\")
  return sn(nil, nodes)
end

-- update for cases
local generate_cases = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2 -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end
local generate_equs = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for equs
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    table.insert(nodes, t({ "\\\\", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end

M = {
  s(
    {
      trig = "([bBpvV]?)mat(%d*)x?(%d*) ",
      name = "[bBpvV]matrix",
      dscr = "matrices",
      regTrig = true,
      hidden = true,
      snippetType = "autosnippet",
    },
    fmta(
      [[
    \begin{<>}
    <>
    \end{<>}]],
      {
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end),
        d(1, generate_matrix),
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end),
      }
    ),
    { condition = tex.in_math }
  ),

  autosnippet(
    { trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true, snippetType = "autosnippet" },
    fmta(
      [[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, generate_cases) }
    ),
    { condition = tex.in_math }
  ),
  autosnippet(
    { trig = "(%d?)equs", name = "equs", dscr = "equs", regTrig = true, hidden = true, snippetType = "autosnippet" },
    fmta(
      [[
    \begin{cases}
    <>
    \end{cases}
    ]],
      { d(1, generate_equs) }
    ),
    { condition = tex.in_math }
  ),
}

return M
