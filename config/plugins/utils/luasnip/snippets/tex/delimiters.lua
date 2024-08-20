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
local tex = require("luasnip-latex-snippets.luasnippets.tex.utils.conditions")
local scaffolding = require("luasnip-latex-snippets.luasnippets.tex.utils.scaffolding")

-- brackets
-- maybe rename to use characters instead of symbols?
local brackets = {
  ["("] = {"(", ")"},
  ["["] = {"[", "]"},
  ["{"] = {"\\{", "\\}"},
  ["<"] = {"\\langle", "\\rangle"},
  ["|"] = {"|", "|"},
  ["d"] = {"\\|", "\\|"},
  ["c"] = {"\\lceil", "\\rceil"},
  ["f"] = {"\\lceil", "\\rceil"},
}

M = {
  autosnippet({ trig = "lr([dcf])", name = "left right", dscr = "left right delimiters", regTrig = true, hidden = true },
    fmta(
    [[
      \left<> <> \right<><>
    ]],
    {
      f(function(_, snip)
        cap = snip.captures[1] or 'p'
        return brackets[cap][1]
      end),
      d(1, scaffolding.get_visual),
      f(function(_, snip)
        cap = snip.captures[1] or 'p'
        return brackets[cap][2]
      end),
      i(0)
    }),
  { condition = tex.in_math, show_condition = tex.in_math }),
}

return M
