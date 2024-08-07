{ mkKeymap, mkKeymapWithOpts, ... }:
{
  plugins.lsp = {
    # NOTE: All packages, including LSPs and formatters should be installed through devshells!!
    enable = true;
    servers = {
      astro = {
        enable = true;
        package = null;
      };
      tsserver = {
        enable = true;
        package = null;
      };
      cssls = {
        enable = true;
        package = null;
      };
      emmet-ls = {
        enable = true;
        package = null;
      };
      eslint = {
        enable = true;
        package = null;
      };
      pyright = {
        enable = true;
        package = null;
      };
      lua-ls = {
        enable = true;
        package = null;
      };
      jsonls = {
        enable = true;
        package = null;
      };
      nixd = {
        enable = true;
        settings = {
          diagnostic.suppress = [
            "sema-escaping-with"
            "var-bind-to-this"
          ];
        };
        package = null;
      };
      # nil-ls = {
      #   enable = true;
      #   package = null;
      # };
      rust-analyzer = {
        enable = true;
        package = null;
        installCargo = false;
        installRustc = false;
        settings.check.command = "clippy";
      };
      hls = {
        enable = true;
        package = null;
      };
      gopls = {
        enable = true;
        package = null;
      };
    };

    keymaps = {
      silent = true;
      diagnostic = {
        "<leader>k" = "goto_prev";
        "<leader>j" = "goto_next";
        "<leader>ll" = "open_float";
      };
      lspBuf = {
        "gd" = "definition";
        "<leader>ld" = "definition";
        "<C-leftmouse>" = "definition";

        "gD" = "implementation";
        "<leader>li" = "implementation";

        "<leader>lr" = "rename";
        "<F2>" = "rename";

        "<leader>la" = "code_action";
        "ca" = "code_action";

        "K" = "hover";
        "<leader>lk" = "hover";
      };
    };
  };

  # Add descriptions to which-key.
  # Items defined in keymaps will have their command as description by default
  plugins.which-key.registrations = {
    "<leader>k" = "Previous diagnostic";
    "<leader>j" = "Next diagnostic";
    "<leader>ll" = "Line diagnostics";
    "<leader>ld" = "Definition";
    "<leader>li" = "Implementation";
    "<leader>lr" = "Rename";
    "<leader>la" = "Code actions";
    "<leader>lk" = "Hover";
  };

  keymaps = [
    (mkKeymap "n" "<leader>lR" ":LspRestart<cr>" "Restart")
    (mkKeymap "n" "<leader>lI" ":LspInfo<cr>" "Info")
  ];

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
      astro = [ "prettier" ];
      html = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      css = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      javascript = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      javascriptreact = [
        [
          "prettierd"
          "prettier"
        ]
      ];
      typescript = [
        [
          "prettierd"
          "prettier"
        ]
      ];
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
      markdown = [
        [
          "prettierd"
          "prettier"
        ]
      ];
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
