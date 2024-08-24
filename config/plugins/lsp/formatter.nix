{ pkgs, ... }:
{
  # Globally installed because it makes obsidian easier to use
  extraPackages = [ pkgs.prettierd ];

  plugins.conform-nvim = {
    enable = true;
    formatOnSave = ''
      function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end
    '';
    formattersByFt = {
      haskell = [ "ormolu" ];
      html = [ [ "prettierd" ] ];
      css = [ [ "prettierd" ] ];
      javascript = [ [ "prettierd" ] ];
      javascriptreact = [ [ "prettierd" ] ];
      typescript = [ [ "prettierd" ] ];
      python = [
        [
          "autopep8"
          "black"
        ]
      ];
      lua = [ "stylua" ];
      nix = [
        [
          "nixfmt"
          "alejandra"
        ]
      ]; # nixfmt, use alejandra as backup
      markdown = [ [ "prettierd" ] ];
      rust = [ "rustfmt" ];
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
