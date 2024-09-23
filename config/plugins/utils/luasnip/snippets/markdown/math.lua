local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip


local M = {
  tsnip({ trig = "mm", name = "inline math" }, [[$$1$]]),
  tsnip({ trig = "md", name = "display math" }, [[
    $$
    $1
    $$
  ]]),
  _msnip({ trig = "aa", name = "answer" }, fmta([[\underline{\underline{<>}}]], {d(1, utils.get_visual)})),
}

return M
