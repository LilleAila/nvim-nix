{
  colorScheme,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  c = lib.attrsets.mapAttrs (_: value: "#${value}") colorScheme.palette;
in
{
  extraConfigLuaPre = ''
    local has_words_before = function()
    	unpack = unpack or table.unpack
    	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
  '';

  highlight = {
    "CmpItemMenu".fg = c.base04; # [Source name]
    "PmenuSel".bg = c.base02; # Selected item (also applies to some other items such as NORMAL in lualine)
  };

  plugins = {
    lspkind = {
      enable = true;
      cmp = {
        enable = true;
        menu = {
          buffer = "[Buffer]";
          nvim_lsp = "[LSP]";
          luasnip = "[LuaSnip]";
          path = "[Path]";
          spell = "[Spell]";
        };
      };
    };

    cmp = {
      enable = true;
      settings = {
        sources = [
          # TODO: move some of these to the correct places
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "calc"; }
          { name = "emoji"; }
          { name = "latex_symbols"; }
          { name = "nerdfont"; }
          { name = "vimtex"; }
        ];

        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
          };
        };

        snippet.expand = # lua
          ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end
          '';

        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-c>" = "cmp.mapping.abort()";

          "<C-Up>" = "cmp.mapping.select_prev_item()";
          "<C-Down>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<cr>" = # lua
            "cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.confirm({ select = true })
              else
                fallback()
              end
            end
          )";

          "<Tab>" = # lua
            ''
              cmp.mapping(
                function(fallback)
                  if require("luasnip").expand_or_locally_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end,
                {"i", "s"}
              )
            '';

          "<S-Tab>" = # lua
            ''
              cmp.mapping(
              function(fallback)
                if require("luasnip").jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end,
              {"i", "s"}
              )
            '';
        };
      };
    };

    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-document-symbol.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-nvim-lua.enable = true;
    cmp_luasnip.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    cmp-calc
    cmp-emoji
    cmp-latex-symbols
    (pkgs.vimUtils.buildVimPlugin {
      name = "cmp-nerdfont";
      src = inputs.plugin-cmp-nerdfont;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "cmp-vimtex";
      src = inputs.plugin-cmp-vimtex;
    })
  ];
}
