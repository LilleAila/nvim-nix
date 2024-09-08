{
  plugins.nvim-autopairs = {
    enable = true;
  };

  extraConfigLua = ''
    local Rule = require("nvim-autopairs.rule")
    local npairs = require("nvim-autopairs")
    npairs.add_rule(Rule("$", "$", "tex"))
    npairs.add_rule(Rule("$$", "$$", "tex"))
  '';
}
