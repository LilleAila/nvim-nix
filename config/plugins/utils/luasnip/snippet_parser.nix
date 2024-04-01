{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  # options.plugins.luasnip.snippet_helpers = lib.mkOption {
  #   type = types.lines;
  #   description = "Helper functions available to snippets defined in `plugins.luasnip.snippets.<lang>.snippets`.";
  #   default = "";
  # };
  options.plugins.luasnip.snippets = lib.mkOption {
    type = types.attrsOf (types.submodule ({
      config,
      name,
      ...
    }: {
      options = {
        lang = mkOption {
          type = types.str;
          default = name;
          description = "Language to use the snippet in. \"all\" for all languages.";
        };
        snippets = mkOption {
          type = types.listOf (types.submodule {
            options = {
              trig = mkOption {
                type = types.str;
                description = "Snippet trigger";
              };
              text = mkOption {
                type = types.str;
                description = "Snippet expansion text";
              };
              nodes = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "Nodes to replace \"<>\" with in text";
                default = null;
              };
              descr = mkOption {
                type = types.nullOr types.str;
                description = "Snippet description";
                default = null;
              };
              auto = mkOption {
                type = types.enum ["off" "auto" "word" "reg"];
                default = "off";
                description = ''
                  Whether the snippet should automaticall expand. Can be one of:

                  "off": Do not automatically expand
                  "word": Expand when preceded by a space
                  "reg": Expand when text matches regex specified in `trig`. Note that this is not actually a regular expression, but a lua pattern.
                '';
              };
              condition = mkOption {
                type = types.nullOr types.str;
                description = "Lua function that returns true if snippet should be expandable";
                default = null;
              };
            };
          });
          default = [];
          description = ''
            List of LuaSnip-snippets
          '';
        };
      };
    }));
    default = {};
    description = ''
      LuaSnip snippets for different languages:
      `plugins.luasnip.snippets.<language>.snippets = [list of snippets]`

      If language is "all", snippets will be available globally.
    '';
  };

  config = lib.mkIf (config.plugins.luasnip.enable) {
    extraConfigLua =
      (
        /*
        lua
        */
        ''
          -- LuaSnip Snippets
          local ls = require("luasnip")
          local s = ls.snippet
          local sn = ls.snippet_node
          local t = ls.text_node
          local i = ls.insert_node
          local f = ls.function_node
          local c = ls.choice_node
          local d = ls.dynamic_node
          local r = ls.restore_node
          local l = require("luasnip.extras").lambda
          local rep = require("luasnip.extras").rep
          local p = require("luasnip.extras").partial
          local m = require("luasnip.extras").match
          local n = require("luasnip.extras").nonempty
          local dl = require("luasnip.extras").dynamic_lambda
          local fmt = require("luasnip.extras.fmt").fmt
          local fmta = require("luasnip.extras.fmt").fmta
          local types = require("luasnip.util.types")
          local conds = require("luasnip.extras.conditions")
          local conds_expand = require("luasnip.extras.conditions.expand")
        ''
      )
      # + config.plugins.luasnip.snippet_helpers
      + builtins.concatStringsSep "\n" (
        # Add snippets for each languages
        lib.attrsets.mapAttrsToList (
          lang: snippets:
            "ls.add_snippets(\"${lang}\", {\n"
            + builtins.concatStringsSep "\n" (
              # Add each individual snippet
              map (snip:
                /*
                lua
                */
                ''
                  s({${
                    builtins.concatStringsSep ", " (
                      [
                        ''trig = "${snip.trig}"''
                      ]
                      ++ lib.optionals (snip.descr != null) [
                        ''descr = "${snip.descr}"''
                      ]
                      ++ lib.optionals (snip.auto == "auto") [
                        ''snippetType = "autosnippet"''
                        ''wordTrig = false''
                        ''regTrig = false''
                      ]
                      ++ lib.optionals (snip.auto == "word") [
                        ''snippetType = "autosnippet"''
                        ''wordTrig = true''
                        ''regTrig = false''
                      ]
                      ++ lib.optionals (snip.auto == "reg") [
                        ''snippetType = "autosnippet"''
                        ''wordTrig = false''
                        ''regTrig = true''
                      ]
                    )
                  }}, ${
                    if snip.nodes != null
                    then ''
                      fmta(
                        [[${snip.text}]],
                        { ${builtins.concatStringsSep ", " (map (node: "\"${node}\"") snip.nodes)} }
                      )
                    ''
                    else "{ t(\"${snip.text}\") }"
                  } ${
                    if snip.condition != null
                    then ", { condition = \"${snip.condition}\" }"
                    else ""
                  }),
                '')
              snippets.snippets
            )
            + "})"
        )
        config.plugins.luasnip.snippets
      );
  };
}
