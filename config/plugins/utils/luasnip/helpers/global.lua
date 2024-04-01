local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local line_begin = require("luasnip.extras.expand_conditions").line_begin

function M.get_visual(_, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

function M.nl_whitespace (line_to_cursor, matched_trigger, captures)
	local whitespaceEnding = not not string.match(line_to_cursor, "%s" .. matched_trigger .. "$")
	local lineStart = line_begin(line_to_cursor, matched_trigger, captures)
	return whitespaceEnding or lineStart
end

return M
