return {
	s(
		{ trig = "tipa", snippetType = "autosnippet" },
		fmta("$|\\tipa{<>}|$", {
			i(1),
		})
	),
	s(
		{ trig = "jj", snippetType = "autosnippet" },
		fmta("$|<>|$ <>", {
			i(1),
			i(0),
		})
	),
	s(
		{ trig = "|$ ([^%a])", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
		fmta("|$<>", {
			f(function(_, snip)
				return snip.captures[1]
			end),
		})
	),
}
