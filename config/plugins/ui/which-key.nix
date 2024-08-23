{ pkgs, mkRegistration, ... }:
{
  plugins.which-key = {
    enable = true;
    settings = {
      delay = 0;
      preset = "helix";
      icons = {
        mappings = false;
        separator = "";
        group = "";
      };
      keys = {
        scroll_down = "<C-d>";
        scroll_up = "<C-u>";
      };
      layout = {
        spacing = 3;
        width.min = 25;
      };
      # Only react to <leader>, and only in normal mode
      triggers = [
        {
          __unkeyed-1 = "<leader>";
          mode = "n";
        }
      ];
    };
  };

  # TODO: move some of these to the correct places
  plugins.which-key.settings.spec = [
    (mkRegistration "<leader>f" " Files")
    (mkRegistration "<leader>fg" " Git")
    (mkRegistration "<leader>b" " Buffers")
    (mkRegistration "<leader>t" " Terminal")
    (mkRegistration "<leader>s" " Sessions")
    (mkRegistration "<leader>l" " LSP")
    (mkRegistration "<leader>lx" " LaTeX")
  ];
}
