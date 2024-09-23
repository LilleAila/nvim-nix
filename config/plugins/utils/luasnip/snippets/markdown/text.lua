local tex = require("luasnip_helpers.tex")
local utils = require("luasnip_helpers.utils")
local tsnip = tex.tsnip
local _tsnip = tex._tsnip
local msnip = tex.msnip
local _msnip = tex._msnip

local M = {
  tsnip({ trig = "cc", name = "code block" }, [[
    ```$1
    $2
    ```
  ]]),
  tsnip({ trig = "h1", name = "heading 1" }, [[# $1]]),
  tsnip({ trig = "h2", name = "heading 2" }, [[## $1]]),
  tsnip({ trig = "h3", name = "heading 3" }, [[### $1]]),
  tsnip({ trig = "h4", name = "heading 4" }, [[#### $1]]),
  tsnip({ trig = "h5", name = "heading 5" }, [[##### $1]]),
  tsnip({ trig = "h6", name = "heading 6" }, [[###### $1]]),
  tsnip({ trig = "qq", name = "quote" }, [[
    > "$1"

    \- $2
  ]]),
}

return M
