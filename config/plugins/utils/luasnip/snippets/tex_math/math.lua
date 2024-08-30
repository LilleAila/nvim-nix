local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip

M = {
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
  msnip({ trig = "*", name = "multiplication" }, [[\cdot]]),
  _msnip({ trig = "^", name = "exponent" }, fmta([[^{<>}]], {d(1, utils.get_visual)})),
  _msnip({ trig = "uu", name = "underset" }, fmta([[\underset{<>}{<>}]], {i(1), d(2, utils.get_visual)})),
  _msnip({ trig = "ss", name = "square root" }, fmta([[\sqrt{<>}]], {d(1, utils.get_visual)})),
  _msnip({ trig = "sr", name = "nth root" }, fmta([=[\sqrt[<>]{<>}]=], {i(1), d(2, utils.get_visual)})),
  -- TODO: de list-relaterte snippetene i https://github.com/LilleAila/nvim-nix/blob/ff3c6efdd0ddc178a9dab31747d7cfbc76f970b8/config/plugins/utils/luasnip/snippets/tex/math.lua (commiten før jeg startet med dette)
}

return M
