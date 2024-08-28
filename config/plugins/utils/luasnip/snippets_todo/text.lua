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
	s({ trig = "(%s)ll", deescr = "Newline with more spacing", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta(
			"<>\\\\[5pt]",
			{ f( function(_, snip) return snip.captures[1] end ) }
		), { condition = tex_utils.in_text }),
	s({ trig = "(%s)nn", deescr = "Newline", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta(
			"<>\\\\",
			{ f( function(_, snip) return snip.captures[1] end ) }
		), { condition = tex_utils.in_text }),
	s({ trig = "pr", descr = "New paragraph", snippetType = "autosnippet", wordTrig = false },
		{ t([[\par]]) },
		{ condition = line_begin }),
	s({ trig = "bold", descr = "Bold text", wordTrig = false },
		fmta(
			[[\textbf{<>}]], -- Get visual does not work here
			{ d(1, get_visual) }
		), { condition = tex_utils.in_text }),
	s({ trig = "ital", descr = "Italic text", wordTrig = false },
		fmta(
			[[\textit{<>}]],
			{ d(1, get_visual) }
		), { condition = tex_utils.in_text }),
	-- These sections use *, and will NOT be shown in the \tableofcontents
	s({ trig = "ssec", descr = "Hidden section", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[\section*{<>}]],
			{ i(1, "Section") }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "ssub", descr = "Hidden subsection", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[\subsection*{<>}]],
			{ i(1, "Subsection") }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "sec", descr = "Section", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[\section{<>}]],
			{ i(1, "Section") }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "sub", descr = "Subsection", wordTrig = false, snippetType = "autosnippet" },
		fmta(
			[[\subsection{<>}]],
			{ i(1, "Subsection") }
		), { condition = tex_utils.in_text_lnstart }),
}
