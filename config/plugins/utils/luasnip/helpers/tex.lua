local M = {}
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local helpers = require('luasnip_helpers.global')
local nl_whitespace = helpers.nl_whitespace
-- IMPORTANT: This file depends on VimTex!!

----- Helper functions
function M.in_mathzone()
	return vim.fn ["vimtex#syntax#in_mathzone"]() == 1
end
function M.in_comment()
	return vim.fn ["vimtex#syntax#in_comment"]() == 1
end
function M.in_env(name)
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0) and not M.in_comment()
end

----- In environments
function M.in_text()
	return not M.in_mathzone()
end
function M.in_list()
	return M.in_env("enumerate")
end
function M.in_tikz()
	return M.in_env("tikzpicture")
end
function M.in_flalign()
	return M.in_env("flalign*")
end

----- In environment on newline
function M.in_text_lnstart(a, b, c)
	return M.in_text() and line_begin(a, b, c)
end
function M.in_list_lnstart(a, b, c)
	return M.in_list() and line_begin(a, b, c)
end
function M.in_tikz_lnstart(a, b, c)
	return M.in_tikz() and line_begin(a, b, c)
end
function M.in_flalign_lnstart(a, b, c)
	return M.in_flalign() and line_begin(a, b, c)
end

----- In environment not on newline
function M.in_text_nlnstart(a, b, c)
	return M.in_text() and not line_begin(a, b, c)
end
function M.in_list_nlnstart(a, b, c)
	return M.in_list() and not line_begin(a, b, c)
end
function M.in_tikz_nlnstart(a, b, c)
	return M.in_tikz() and not line_begin(a, b, c)
end
function M.in_flalign_nlnstart(a, b, c)
	return M.in_flalign() and not line_begin(a, b, c)
end

function M.in_list_nlnstart_math(a, b, c)
	return M.in_list_nlnstart(a, b, c) and M.in_mathzone()
end

----- In environment and on either newline or after whitespace
function M.in_text_wsnl(a, b, c)
	return M.in_text() and nl_whitespace(a, b, c)
end
function M.in_list_wsnl(a, b, c)
	return M.in_list() and nl_whitespace(a, b, c)
end
function M.in_tikz_wsnl(a, b, c)
	return M.in_tikz() and nl_whitespace(a, b, c)
end
function M.in_flalign_wsnl(a, b, c)
	return M.in_flalign() and nl_whitespace(a, b, c)
end
function M.in_mathzone_wsnl(a, b, c)
	return M.in_mathzone() and nl_whitespace(a, b, c)
end

return M
