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

M = {}

-- AND a list of functions to be used as a condition
-- `and` is a reserved keyword
function M.and_condition(functions)
  return function()
    for _, func in ipairs(functions) do
      if not func() then
        return false
      end
    end
    return true
  end
end

-- OR a list of functions to be used as a condition
function M.or_condition(functions)
  return function()
    for _, func in ipairs(functions) do
      if func() then
        return true
      end
    end
    return false
  end
end

-- Get text from pressing <tab>
-- Something like this would also work: https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/4b91f28d91979f61a3e8aef1cee5b7c7f2c7beb8/lua/luasnip-latex-snippets/math_i.lua#L43
function M.get_visual(args, parent)
  if #parent.snippet.env.SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

function M.get_cap(index)
  return f(function(_, snip)
    return snip.captures[index]
  end)
end

-- M.line_begin = require("luasnip.extras.expand_conditions").line_begin

-- autosnippet
M.asnip = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

return M
