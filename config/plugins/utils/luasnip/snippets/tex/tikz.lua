local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local ms = ls.multi_snippet

local helpers = require('luasnip_helpers.global')
local get_visual = helpers.get_visual
local nl_whitespace = helpers.nl_whitespace
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local tex_utils = require("luasnip_helpers.tex")

return {
	-- s({ trig = "tt", descr = "Tikz picture", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[
	-- 			\begin{tikzpicture}[scale=<>]
	-- 				<>
	-- 			\end{tikzpicture}
	-- 		]],
	-- 		{ i(1, "1.0"), i(2) }
	-- 	), { condition = tex_utils.in_text_lnstart }),
	-- s({ trig = "tc", descr = "Centered tikzpictura", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[
	-- 			\begin{center}
	-- 				\begin{tikzpicture}[scale=<>]
	-- 					<>
	-- 				\end{tikzpicture}
	-- 			\end{center}
	-- 		]],
	-- 		{ i(1, "1.0"), i(2) }
	-- 	), { condition = tex_utils.in_text_lnstart }),
	-- ---------- Generic
	-- s({ trig = "dd", descr = "Generic draw", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[\draw[<>] ]],
	-- 		{ i(1) }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- ---------- Lines
	-- s({ trig = "dl", descr = "Draw lines", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[\draw[<>] (<>,<>)]],
	-- 		{ i(1), i(2), i(3) }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- s({ trig = "(%s)dl", descr = "Draw new coordinate", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	-- 	fmta(
	-- 		[[<>-- (<>,<>)]],
	-- 		{ f( function(_, snip) return snip.captures[1] end ), i(1), i(2) }
	-- 	), { condition = tex_utils.in_tikz_nlnstart }),
	-- s({ trig = "(%s)de", descr = "Cycle draw", snippetType = "autosnippet", regTrig = true, wordTrig = false },
	-- 	fmta(
	-- 		[[<>-- cycle;]],
	-- 		{ f( function(_, snip) return snip.captures[1] end ) }
	-- 	), { condition = tex_utils.in_tikz_nlnstart }),
	-- ---------- Shapes
	-- s({ trig = "rr", descr = "Draw rectangle", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[(<>,<>) rectangle (<>,<>);]],
	-- 		{ i(1), i(2), i(3), i(4) }
	-- 	), { condition = tex_utils.in_tikz_nlnstart }),
	-- s({ trig = "ci", descr = "Draw circle", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[(<>,<>) circle (<>cm);]],
	-- 		{ i(1), i(2), i(3) }
	-- 	), { condition = tex_utils.in_tikz_nlnstart }),
	-- s({ trig = "ee", descr = "Draw ellipse", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[(<>,<>) ellipse (<>cm and <>cm);]],
	-- 		{ i(1), i(2), i(3), i(4) }
	-- 	), { condition = tex_utils.in_tikz_nlnstart }),
	-- ---------- Grids
	-- s({ trig = "gg", descr = "Draw grid", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[\draw[step=<>cm,gray,very thin] (<>,<>) grid (<>,<>);]],
	-- 		{ i(1, "1"), i(2, "Bottom"), i(3, "Left"), i(4, "Top"), i(5, "Right") }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- s({ trig = "ff", descr = "Fill color", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[\fill[<>!50!white] ]],
	-- 		{ i(1, "blue") }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- s({ trig = "fb", descr = "Fill with border", snippetType = "autosnippet", wordTrig = false},
	-- 	fmta(
	-- 		[[\filldraw[fill=<>!50!white, draw=black] ]],
	-- 		{ i(1, "blue") }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- s({ trig = "aa", descr = "Draw axes", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[
	-- 			\draw[very thick,-<>] (0,0) -- (<>,0) node[anchor=north west] {<>};
	-- 			\draw[very thick,-<>] (0,0) -- (0,<>) node[anchor=south east] {<>};
	-- 		]],
	-- 		{ t(">"), i(1, "8.5"), i(2, "x-akse"), t(">"), i(3, "8.5"), i(4, "y-akse") }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
	-- s({ trig = "an", descr = "Axes numbers", snippetType = "autosnippet", wordTrig = false },
	-- 	fmta(
	-- 		[[
	-- 			\foreach \x in {<>,<>,...,<>}
	-- 				\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\x$};
	-- 			\foreach \y in {<>,<>,...,<>}
	-- 				\draw (1pt, \y cm) -- (-1pt, \y cm) node[anchor=east] {$\y$};
	-- 		]],
	-- 		{ i(1, "0"), i(2, "Step"), i(3, "8"), i(4, "0"), i(5, "Step"), i(6, "8") }
	-- 	), { condition = tex_utils.in_tikz_lnstart }),
}
