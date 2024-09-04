local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip


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
  _msnip({ trig = "lr([%(%[{<|dcf])", name = "left right", dscr = "left right delimiters", regTrig = true  },
    fmta(
    [[
      \left<> <> \right<><>
    ]],
    {
      f(function(_, snip)
        cap = snip.captures[1] or '('
        return brackets[cap][1]
      end),
      d(1, utils.get_visual),
      f(function(_, snip)
        cap = snip.captures[1] or '('
        return brackets[cap][2]
      end),
      i(0)
    })),
  _msnip({ trig = "l([%(%[{<|dcf])", name = "left", dscr = "left delimiters", regTrig = true  },
    fmta(
    [[
      \left<> <> \right.<>
    ]],
    {
      f(function(_, snip)
        cap = snip.captures[1] or '('
        return brackets[cap][1]
      end),
      d(1, utils.get_visual),
      i(0)
    })),
  _msnip({ trig = "r([%(%[{<|dcf])", name = "right", dscr = "right delimiters", regTrig = true },
    fmta(
    [[
      \left. <> \right<><>
    ]],
    {
      d(1, utils.get_visual),
      f(function(_, snip)
        cap = snip.captures[1] or '('
        return brackets[cap][2]
      end),
      i(0)
    })),
}

return M
