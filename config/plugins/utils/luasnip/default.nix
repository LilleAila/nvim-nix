# https://evesdropper.dev/files/luasnip/
# https://github.com/evesdropper/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/luasnippets/tex/delimiters.lua
# https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_iA.lua
# TODO: use this syntax for simple snippets: https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/4b91f28d91979f61a3e8aef1cee5b7c7f2c7beb8/lua/luasnip-latex-snippets/math_iA.lua#L125 but with auto and word trig

{ ... }:
{
  plugins.luasnip = {
    enable = true;
    extraConfig = {
      update_events = "TextChanged,TextChangedI";
      store_selection_keys = "<Tab>";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      history = false;
    };
    fromLua = [
      {
        paths = ./snippets;
        lazyLoad = true;
      }
    ];
  };

  # Helper files for the snippets
  extraFiles = {
    "lua/luasnip_helpers/tex.lua".source = ./helpers/tex.lua;
    "lua/luasnip_helpers/global.lua".source = ./helpers/global.lua;
    "lua/luasnip_helpers/latex/init.lua".source = ./helpers/latex/init.lua;
    "lua/luasnip_helpers/latex/conditions.lua".source = ./helpers/latex/conditions.lua;
    "lua/luasnip_helpers/latex/scaffolding.lua".source = ./helpers/latex/scaffolding.lua;
  };
}
