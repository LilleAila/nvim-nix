{...}: {
  imports = [
    ./oil.nix
    ./sessions.nix
    ./telescope.nix
    ./guess-indent.nix
    ./hop.nix
    ./toggleterm.nix
    ./img-clip.nix
    ./move.nix
    ./mini.nix
    ./luasnip
  ];

  plugins = {
    nvim-autopairs.enable = true;
    comment-nvim = {
      enable = true;
      padding = true;
    };
    direnv.enable = true;
  };

  plugins.luasnip = {
    enable = true;
    extraConfig = {
      update_events = "TextChanged,TextChangedI";
      store_selection_keys = "<Tab>";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      history = false;
    };
    # fromLua = [
    #   {
    #     path = ./luasnip;
    #     lazyLoad = true;
    #   }
    # ];
    snippets.all.snippets = [
      {
        trig = "hi";
        text = "Hello, World!";
      }
    ];
  };

  # extraConfigLua = let
  #   mkSnippet' = trig: auto: word: reg: descr: text: nodes: condition: ''
  #     s({
  #       trig = "${trig}",
  #       descr = "${descr}"
  #       ${
  #       if auto
  #       then ''
  #         ,
  #         snippetType = "autosnippet",
  #         wordTrig = ${
  #           if word
  #           then "true"
  #           else "false"
  #         },
  #         regTrig = ${
  #           if reg
  #           then "true"
  #           else "false"
  #         }
  #       ''
  #       else ""
  #     }
  #     }, fmta(
  #       [[${text}]],
  #       { ${nodes} }
  #     ),
  #     { ${condition} })
  #   '';
  #   mkSimpleSnippet = trig: descr: text: ''
  #     s({ trig = "${trig}", descr = "${descr}" }, { t("${text}") })
  #   '';
  # in
  #   /*
  #   lua
  #   */
  #   ''
  #     local ls = require("luasnip")
  #     local s = ls.snippet
  #     local sn = ls.snippet_node
  #     local t = ls.text_node
  #     local i = ls.insert_node
  #     local f = ls.function_node
  #     local d = ls.dynamic_node
  #     local fmt = require("luasnip.extras.fmt").fmt
  #     local fmta = require("luasnip.extras.fmt").fmta
  #     local rep = require("luasnip.extras").rep
  #     local ms = ls.multi_snippet
  #
  #     ls.add_snippets("all", {
  #       s({ trig = "hi", descr = "Hello" }, { t("Hello, World!") })
  #       })
  #   '';
}
