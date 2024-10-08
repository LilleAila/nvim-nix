# https://evesdropper.dev/files/luasnip/
# https://github.com/evesdropper/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/luasnippets/tex/delimiters.lua
# https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_iA.lua
# TODO: use this syntax for simple snippets: https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/4b91f28d91979f61a3e8aef1cee5b7c7f2c7beb8/lua/luasnip-latex-snippets/math_iA.lua#L125 but with auto and word trig

_:
{
  plugins.luasnip = {
    enable = true;
    settings = {
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
    # Shared math snippets between markdown and tex to be used in embedded math blocks
    # This for some reason generates invalid syntax: it does
    # `require("luasnip").extend_filetypes("markdown", { "tex_math" })`
    # instead of
    # `require("luasnip").filetype_extend("markdown", { "tex_math" })`
    # filetypeExtend = {
    #   markdown = [ "tex_math" ];
    #   tex = [ "tex_math" ];
    # };
  };

  extraConfigLua = ''
    require("luasnip").filetype_extend("markdown", {"tex_math"})
    require("luasnip").filetype_extend("tex", {"tex_math"})
  '';

  # Helper files for the snippets
  extraFiles = {
    "lua/luasnip_helpers/init.lua".source = ./helpers/init.lua;
    "lua/luasnip_helpers/tex.lua".source = ./helpers/tex.lua;
    "lua/luasnip_helpers/utils.lua".source = ./helpers/utils.lua;
  };
}
