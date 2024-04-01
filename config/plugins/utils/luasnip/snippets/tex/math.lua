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
		s({ trig = "mm", descr = "Inline Math", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[<>$ <> $]],
			{ f( function(_, snip) return snip.captures[1] end ), i(1) }
		), { condition = tex_utils.in_text_wsnl }),
	s({ trig = "ml", descr = "Multiline Math", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[
				\begin{flalign*}
					& <> & <>
				\end{flalign*}
			]],
			{ i(1), i(0) }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "(%s)ll", descr = "Left-aligned newline", snippetType = "autosnippet", wordTrig = false, regTrig = true },
		fmta(
			[[
				<> \\[5pt]
				& <> &
			]],
			{ f( function(_, snip) return snip.captures[1] end ), i(1) }
		), { condition = tex_utils.in_flalign }),
	s({ trig = "me", descr = "Unnumbered equation" },
		fmta(
			[[
				\begin{equation*}
					<>
				\end{equation*}
			]],
			{ i(1) }
		), { condition = tex_utils.in_text_lnstart }),
	---------------------
	s({ trig = "^", descr = "Exponent", snippetType = "autosnippet", wordTrig = false},
		fmta(
			[[^{<>}]],
			{ i(1) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "pp", descr = "Parenthesis", snippetType = "autosnippet", wordTrig = true, regTrig = false },
		fmta(
			[[\left(<>\right)]],
			{ i(1) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "ff", descr = "Fraction", snippetType = "autosnippet", wordTrig = true },
		fmta(
			[[\frac{<>}{<>}]],
			{ i(1), i(2) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "([%s])*", descr = "Multiplication sign", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta(
			[[<>\cdot]],
			{ f( function(_, snip) return snip.captures[1] end ) }
		),
		-- { t([[\cdot]]) },
		{ condition = tex_utils.in_mathzone }),
	s({ trig = "([%s])aa", descr = "Answer (Double underline)", snippetType = "autosnippet", wordTrig = false, regTrig = true },
		fmta(
			[[
				<>\underline{\underline{<>}}
			]],
			{ f( function(_, snip) return snip.captures[1] end ), d(1, get_visual) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "und", descr = "Underset text (below other text)", wordTrig = false },
		fmta(
			[[\underset{<>}{<>}]],
			{ i(1, "Under"), d(2, get_visual) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "ss", descr = "Square root", wordTrig = true, snippetType="autosnippet" },
		fmta(
			[[\sqrt{<>}]],
			{ i(1) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "rr", descr = "Nth root", wordTrig = true, snippetType="autosnippet" },
		fmta(
			[[\sqrt[<>]{<>}]],
			{ i(1), i(2) }
		), { condition = tex_utils.in_mathzone }),
	----------
	-- List --
	----------
	s({ trig = "ls", descr = "List a) b) c)", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
				\begin{enumerate}
					<>
				\end{enumerate}
			]],
			{ i(1) }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "lr", descr = "Resume list", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[
				\begin{enumerate}[resume]
					<>
				\end{enumerate}
			]],
			{ i(1) }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "li", descr = "List item", snippetType = "autosnippet", wordTrig = false },
		fmta(
			[[<>\item <>]],
			{ f( function(_, snip) return snip.captures[1] end ), i(1) }
		), { condition = tex_utils.in_list_lnstart }),
	s({ trig = "(%s)lm", descr = "List multiline math", snippetType = "autosnippet", wordTrig = false, regTrig = true },
		fmta(
			[[
				<>
					\begin{flalign*}
						& <> & <>
					\end{flalign*}
			]],
			{ f( function(_, snip) return snip.captures[1] end ), i(1), i(2) }
		), { condition = tex_utils.in_list_nlnstart }),
	s({ trig = "(%s)ll", descr = "List math line", snippetType = "autosnippet", wordTrig = false, regTrig = true },
		fmta(
			[[
				<>\\[5pt]
				& <> &
			]],
			{ f( function(_, snip) return snip.captures[1] end ), i(1) }
		), { condition = tex_utils.in_list_nlnstart_math }),


	-- s({ trig = "yy", descr = "Symbol", snippetType = "autosnippet", wordTrig = false },
	-- 	{ t([[\]]), i(1) }, { condition = tex_utils.in_mathzone }),
	-- s({ trig = "lor", descr = "Logical or", snippetType = "autosnippet", wordTrig = true },
	-- 	{ t([[\lor]]) }, { condition = tex_utils.in_mathzone }),
	-- s({ trig = "land", descr = "Logical and", snippetType = "autosnippet", wordTrig = true },
	-- 	{ t([[\land]]) }, { condition = tex_utils.in_mathzone }),
	-- s({ trig = "pi", descr = "pi", snippetType = "autosnippet", wordTrig = true },
	-- 	{ t([[\pi]]) }, { condition = tex_utils.in_mathzone }),
}
