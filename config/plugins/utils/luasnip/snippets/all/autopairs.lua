local utils = require("luasnip_helpers.utils")
local asnip = utils.asnip

local function delimiterSnip(char1, char2)
  char2 = char2 or char1
  return asnip(
    { trig = "([^%a%dæøåÆØÅ])%" .. char1, wordTrig = false, regTrig = true },
    { utils.get_cap(1), t(char1), i(1), t(char2) }
  )
end

local M = {
  delimiterSnip("\""),
  delimiterSnip("'"), -- also works as '' in nix by expanding twice
  delimiterSnip("(", ")"),
  delimiterSnip("[", "]"), -- escaped because regex
  delimiterSnip("{", "}"),
}

return M
