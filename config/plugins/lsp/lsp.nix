{ mkKeymap, mkRegistration, ... }:
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
  plugins.which-key.settings.spec = [
    (mkRegistration "<leader>k" "Previous diagnostic")
    (mkRegistration "<leader>j" "Next diagnostic")
    (mkRegistration "<leader>ll" "Line diagnostics")
    (mkRegistration "<leader>ld" "Definition")
    (mkRegistration "<leader>li" "Implementation")
    (mkRegistration "<leader>lr" "Rename")
    (mkRegistration "<leader>la" "Code actions")
    (mkRegistration "<leader>lk" "Hover")
  ];

  keymaps = [
    (mkKeymap "n" "<leader>lR" ":LspRestart<cr>" "Restart")
    (mkKeymap "n" "<leader>lI" ":LspInfo<cr>" "Info")
  ];
}
