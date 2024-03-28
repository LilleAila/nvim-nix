{...}: {
  plugins.which-key = {
    enable = true;
    registrations = {
      "<leader>f".name = " Files";
      "<leader>fg".name = " Git";
      "<leader>b".name = " Buffers";
      "<leader>t".name = " Terminal";
      "<leader>s".name = " Sessions";
      "<leader>l".name = " LSP";
      "<leader>lx".name = " LaTeX";
    };
    icons = {
      separator = "";
      group = "";
    };
    triggersBlackList = {
      i = ["h" "j" "k" "l" "v"];
      v = ["h" "j" "k" "l"];
    };
  };
}
