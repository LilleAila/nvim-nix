{
  extraConfigLuaPre = ''
    local has_words_before = function()
    	unpack = unpack or table.unpack
    	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
  '';

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
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "luasnip"; }
          { name = "path"; }
        ];

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
}
