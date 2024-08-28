local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- other imports
local tex = require("luasnip_helpers.latex.tex")
local utils = require("luasnip_helpers.latex.utils")


-- These should not be autosnippets, and can have longer and more descriptive triggers
-- Non-autosnippets are triggered with tab, or whichever key is set to trigger them
return {
	s({ trig = "kv1", descr = "Første kvadratsetning", wordTrig = false },
		fmta(
			[[\left(<>+<>\right)^{2} = <>^{2} + 2 \cdot <> \cdot <> + <>^{2}]],
			{ i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
		), { condition = tex.in_math }),
	s({ trig = "kv2", descr = "Andre kvadratsetning", wordTrig = false },
		fmta(
			[[\left(<>-<>\right)^{2} = <>^{2} - 2 \cdot <> \cdot <> + <>^{2}]],
			{ i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
		), { condition = tex.in_math }),
	s({ trig = "kv3", descr = "Tredje kvadratsetning / konjugatsetningen", wordTrig = false },
		fmta(
			[[\left(<>+<>\right) \left(<>-<>\right) = <>^{2} - <>^{2}]],
			{ i(1), i(2), rep(1), rep(2), rep(1), rep(2) }
		), { condition = tex.in_math }),
	s({ trig = "abc", descr = "ABC-formelen", wordTrig = false },
		fmta(
			[[x = \frac{-<> \pm \sqrt{<>^{2} - 4 \cdot <> \cdot <>}}{2 \cdot <>} ]],
			{i(2, "b"), rep(2), rep(1), i(3, "c"), i(1, "a")}
		), { condition = tex.in_math }),
}
