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
local tex = require("luasnip_helpers.latex.conditions")
local scaffolding = require("luasnip_helpers.latex.scaffolding")

local snip = ls.extend_decorator.apply(parse, {
  snippetType = "autosnippet",
  condition = tex.in_math,
  show_condition = tex.in_math
})
local tsnip = ls.extend_decorator.apply(parse, {
  snippetType = "autosnippet",
  condition = tex.in_text,
  show_condition = tex.in_text
})

M = {
  tsnip({ trig = "mm", name = "inline math" }, [[$ $1 $]])
  -- TODO: resten av snipetene
}

return M
