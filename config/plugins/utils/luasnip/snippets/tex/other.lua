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
	s({ trig = "nc", descr = "New document command", snippetType = "autosnippet", wordTrig = false, regTrig = false },
		fmta(
			[[
				\NewDocumentCommand{\<>}{ <> }{
					<>
				}
			]],
			{ i(1, "name"), i(2, "m 0{0}  (m for mandatory var and 0{default_val} for optional)"), i(3, "Variables with #1 and #2 etc.") }
		), {condition = tex_utils.in_text_lnstart }),
	s({ trig = "bb", descr = "Code block", snippetType = "autosnippet", wordTrig = false, regTrig = false },
		fmta(
			[[
				\begin{mintedbox}
				\begin{minted}{<>}
				<>
				\end{minted}
				\end{mintedbox}
			]],
			{ i(1, "python"), i(2) }
		), { condition = tex_utils.in_text_lnstart }),
	s({ trig = "bi", descr = "Code block import", snippetType = "autosnippet", wordTrig = false, regTrig = false },
		fmta(
			[[
				\begin{mintedbox}
					\inputminted{<>}{<>}
				\end{mintedbox}
			]],
			{ i(1, "python"), i(2, "main.py") }
		), { condition = tex_utils.in_text_lnstart }),


	s({ trig = "env", descr = "Generic environment", snippetTYpe = "autosnippet", wordTrig = false },
		fmta(
			[[
				\begin{<>}
					<>
				\end{<>}
			]],
			{ i(1), i(2), rep(1) }
		), { condition = tex_utils.in_text_lnstart }),

	s({ trig="(%d*)c(%d*)c", name = "Cmd with n args", dscr = "command", snippetType = "autosnippet", regTrig = true, hidden = true },
	fmta([[
	\<><> 
	]],
	{
		i(1),
		d(2, function(_, snip)
			local nodes = {}
			local num_ins_nodes = 0

			local num_opt_args = tonumber(snip.captures[1])
			if num_opt_args ~= nil then
				for j = 1, num_opt_args do
					table.insert(nodes, t("["))
					table.insert(nodes, i(j))
					table.insert(nodes, t("]"))
					num_ins_nodes = j
				end
			end

			local num_args = tonumber(snip.captures[2])
			if num_args ~= nil then
				for j = 1, num_args do
					table.insert(nodes, t("{"))
					table.insert(nodes, i(j + num_ins_nodes))
					table.insert(nodes, t("}"))
				end
			end

			return sn(nil, nodes)
		end)
	}
	)),

	s("example4", fmt([[
  repeat {a} with the same key {a}
  ]], {
    a = i(1, "this will be repeat")
  }, {
    repeat_duplicates = true
  }))
}
