local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip


M = {
  _msnip({ trig = "(%s)(.-)/", name = "fraction", regTrig = true, wordTrig = false  },
    fmta(
    [[
      <>\frac{<>}{<>}<>
    ]],
    {
      f(function(_, snip) return snip.captures[1] end),
      f(function(_, snip) return snip.captures[2] end),
      i(1),
      i(0)
    })),
  _msnip({ trig = "ft", name = "fraction teller" },
    fmta(
    [[
      \frac{<>}{<>}<>
    ]],
    {
      d(2, utils.get_visual),
      i(1),
      i(0)
    })),
  _msnip({ trig = "fn", name = "fraction nevner" },
    fmta(
    [[
      \frac{<>}{<>}<>
    ]],
    {
      i(1),
      d(2, utils.get_visual),
      i(0)
    })),
  msnip({ trig = "ff", name = "fraction" }, [[\frac{$1}{$2}]])
}

return M
