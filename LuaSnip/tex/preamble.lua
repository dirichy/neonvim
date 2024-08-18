local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta
local tex = require("latex.conditions.luasnip")
M = {
	s({ trig = "pkg", snippetType = "autosnippet" }, {
		t("\\usepackage{"),
		i(1),
		t("}"),
	}, { condition = tex.in_preamble * line_begin }),
	s(
		{ trig = "(%d?)(r?)env", regTrig = true, snippetType = "autosnippet" },
		fmta(
			[[
    \<>newenvironment{<>}<>%
    {<>}%
    {<>}
    ]],
			{
				f(function(_, snip)
					return snip.captures[2] ~= "" and "re" or ""
				end),
				i(1),
				f(function(_, snip)
					return snip.captures[1] ~= "" and "[" .. snip.captures[1] .. "]" or ""
				end),
				i(2),
				i(3),
			}
		),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = "(%d?)(r?)cmd", regTrig = true, snippetType = "autosnippet" },
		fmta("\\<>newcommand{\\<>}<>{<>}", {
			f(function(_, snip)
				return snip.captures[2] ~= "" and "re" or ""
			end),
			i(1),
			f(function(_, snip)
				return snip.captures[1] ~= "" and "[" .. snip.captures[1] .. "]" or ""
			end),
			i(2),
		}),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = "opt", snippetType = "autosnippet" },
		fmta("\\DeclareMathOperator{\\<>}{<>}", {
			i(1),
			rep(1),
		}),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = "Opt", snippetType = "autosnippet" },
		fmta("\\DeclareMathOperator{\\<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = "thm", snippetType = "autosnippet" },
		fmta("\\newtheorem{<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = "@@@", snippetType = "autosnippet" },
		fmta(
			[[
\makeatletter
<>
\makeatother
    ]],
			{
				i(1),
			}
		),
		{ condition = tex.in_preamble * line_begin }
	),
	s(
		{ trig = ".do", snippetType = "autosnippet" },
		fmta(
			[[
\documentclass{<>}
<>
\begin{document}
<>
\end{document}
      ]],
			{
				i(1),
				i(2),
				i(0),
			}
		),
		{ condition = tex.in_preamble * line_begin }
	),
}
return M
