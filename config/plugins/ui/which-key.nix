{...}: {
  plugins.which-key = {
    enable = true;
    registrations = {
      "<leader>e".name = " Files";
      "<leader>t".name = " Telescope";
      "<leader>m".name = " Terminal";
      "<leader>s".name = " Sessions";
      "<leader>x".name = " LaTeX";
      "<leader>l".name = " LSP";
      "<leader>b".name = " Buffers";
      "<leader>tg".name = " Git";
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
