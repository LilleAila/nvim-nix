local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip

return {
  _msnip({ trig = "kv1", descr = "Første kvadratsetning" },
    fmta(
      [[\left(<>+<>\right)^{2} = <>^{2} + 2 \cdot <> \cdot <> + <>^{2}]],
      { i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
    )),
  _msnip({ trig = "kv2", descr = "Andre kvadratsetning" },
    fmta(
      [[\left(<>-<>\right)^{2} = <>^{2} - 2 \cdot <> \cdot <> + <>^{2}]],
      { i(1), i(2), rep(1), rep(1), rep(2), rep(2) }
    )),
  s({ trig = "kv3", descr = "Tredje kvadratsetning / konjugatsetningen" },
    fmta(
      [[\left(<>+<>\right) \left(<>-<>\right) = <>^{2} - <>^{2}]],
      { i(1), i(2), rep(1), rep(2), rep(1), rep(2) }
    ), { condition = tex.in_math }),
  s({ trig = "abc", descr = "ABC-formelen" },
    fmta(
      [[x = \frac{-<> \pm \sqrt{<>^{2} - 4 \cdot <> \cdot <>}}{2 \cdot <>} ]],
      {i(2, "b"), rep(2), rep(1), i(3, "c"), i(1, "a")}
    )),
}
