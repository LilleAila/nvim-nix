{ ... }:
{
  imports = [
    # TODO: at some point, implement it fully and port my snippets
    # ./snippet_parser.nix
  ];

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
    # snippets.all.snippets = [
    #   {
    #     trig = "hi";
    #     text = "Hello, World!";
    #   }
    # ];
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
