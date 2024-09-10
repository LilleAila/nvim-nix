{ pkgs, ... }:
{
  # Globally installed because it makes obsidian easier to use
  extraPackages = [ pkgs.prettierd ];

  plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts.timeout_ms = 2500;
      format_on_save = ''
        function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end
      '';
      formatters_by_ft =
        let
          mkFormatter = __unkeyed-1: __unkeyed-2: {
            inherit __unkeyed-1 __unkeyed-2;
            stop_after-first = true;
          };
        in
        {
          haskell = [ "ormolu" ];
          html = mkFormatter "prettierd" "prettier";
          css = mkFormatter "prettierd" "prettier";
          javascript = mkFormatter "prettierd" "prettier";
          javascriptreact = mkFormatter "prettierd" "prettier";
          typescript = mkFormatter "prettierd" "prettier";
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = mkFormatter "nixfmt" "alejandra";
          markdown = mkFormatter "prettierd" "prettier";
          rust = [ "rustfmt" ];
        };
    };
  };

  extraConfigLua = ''
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  '';
}
