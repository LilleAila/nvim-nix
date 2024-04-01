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

-- These should not be autosnippets, and can have longer and more descriptive triggers
-- Non-autosnippets are triggered with tab, or whichever key is set to trigger them
return {
	s({ trig = "kv1", descr = "Første kvadratsetning", wordTrig = false },
		fmta(
			[[\left(<>+<>\right)^{2} = <>^{2} + 2 \cdot <> \cdot <> + <>^{2}]],
			{ i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "kv2", descr = "Andre kvadratsetning", wordTrig = false },
		fmta(
			[[\left(<>-<>\right)^{2} = <>^{2} - 2 \cdot <> \cdot <> + <>^{2}]],
			{ i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "kv3", descr = "Tredje kvadratsetning / konjugatsetningen", wordTrig = false },
		fmta(
			[[\left(<>+<>\right) \left(<>-<>\right) = <>^{2} - <>^{2}]],
			{ i(1), i(2), rep(1), rep(2), rep(1), rep(2) }
		), { condition = tex_utils.in_mathzone }),
	s({ trig = "abc", descr = "ABC-formelen", wordTrig = false },
		fmta(
			[[x = \frac{-<> \pm \sqrt{<>^{2} - 4 \cdot <> \cdot <>}}{2 \cdot <>} ]],
			{i(2, "b"), rep(2), rep(1), i(3, "c"), i(1, "a")}
		), { condition = tex_utils.in_mathzone }),
}
