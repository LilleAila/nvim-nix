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

local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

local function in_nodes(node_types)
  local node = ts_utils.get_node_at_cursor()
  -- Traverse the node tree
  while node do
    local node_type = node:type()
    -- Lua has no `in` operator. Could use a "set" where { a = true, b = true } etc. instead?
    for _, t in ipairs(node_types) do
      if node_type == t then
        return true
      end
    end
    node = node:parent()
  end
  return false
end

local math_nodes = {
  "math_environment", -- \begin{equation} \end{equation}
  "inline_formula", -- $ $
  "displayed_equation" -- $$ $$
}

function M.in_math()
  return in_nodes(math_nodes)
end

function M.in_text()
	return not M.in_math()
end

-- math snippet
local math_conditions = {
  snippetType = "autosnippet",
  condition = M.in_math,
  show_condition = M.in_math,
  hidden = true
}
M.msnip = ls.extend_decorator.apply(parse, math_conditions)
M._msnip = ls.extend_decorator.apply(s, math_conditions)
-- text snippet
local text_conditions = {
  snippetType = "autosnippet",
  condition = M.in_text,
  show_condition = M.in_text
}
M.tsnip = ls.extend_decorator.apply(parse, text_conditions)
M._tsnip = ls.extend_decorator.apply(s, text_conditions)

return M
