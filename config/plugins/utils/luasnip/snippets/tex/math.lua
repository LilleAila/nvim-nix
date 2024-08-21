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

-- math snippet
local msnip = ls.extend_decorator.apply(parse, {
  snippetType = "autosnippet",
  condition = tex.in_math,
  show_condition = tex.in_math
})
-- text snippet
local tsnip = ls.extend_decorator.apply(parse, {
  snippetType = "autosnippet",
  condition = tex.in_text,
  show_condition = tex.in_text
})

M = {
  -- init math
  tsnip({ trig = "mm", name = "inline math" }, [[$ $1 $]]),
  tsnip({ trig = "mf", name = "flalign math" }, [[
    \begin{flalign*}
      $1&$2 & $0
    \end{flalign*}
  ]]),
  tsnip({ trig = "ma", name = "align math" }, [[
    \begin{align*}
      $1&$2 & $0
    \end{align*}
  ]]),
  -- align-environments
  -- for some reason \\ expands to \ even when it's inside [[]] /shrug
  msnip({ trig = "nn", name = "newline" }, [[
    \\\\
    $1&$2 & $0
  ]]),
  msnip({ trig = "na", name = "newline with answer" }, [[
    \\\\
    \ans{$1&$2} & $0
  ]]),
  msnip({ trig = "^", name = "exponent", wordTrig = false }, [[^{$1}]]),
  msnip({ trig = "*", name = "multiplication" }, [[*]]),
  -- TODO: skrive disse om til å bruke get_visual? det er potensielt mulig med extend_decorator, eller i hvertfall en mellomfunksjon
  msnip({ trig = "und", name = "underset" }, [[\underset{$1}{$2}]]),
  msnip({ trig = "aa", name = "answer" }, [[\ans{$1}]]),
  msnip({ trig = "sr", name = "square root" }, [[\sqrt{$1}]]),
  msnip({ trig = "sr", name = "nth root", [[\sqrt[$1]{$2}]]}),
  -- TODO: de list-relaterte snippetene i https://github.com/LilleAila/nvim-nix/blob/ff3c6efdd0ddc178a9dab31747d7cfbc76f970b8/config/plugins/utils/luasnip/snippets/tex/math.lua (commiten før jeg startet med dette)
}

return M
