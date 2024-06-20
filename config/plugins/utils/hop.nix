{
  pkgs,
  mkKeymap,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [
    hop-nvim
  ];
  extraConfigLua = ''
    require("hop").setup {
      keys = "asdfghjkløæqwertyuiopåzxcvbnm,.-",
    }
  '';
  keymaps = [
    (mkKeymap "n" "<leader><space>" ":HopChar1<cr>" "Hop")
    (mkKeymap "n" "<leader>hl" ":HopLine<cr>" "Line")
    (mkKeymap "n" "<leader>h1" ":HopChar1<cr>" "1 Char")
    (mkKeymap "n" "<leader>h2" ":HopChar2<cr>" "2 Chars")
    (mkKeymap "n" "<leader>hc" ":HopChar1CurrentLine<cr>" "Current line")
    (mkKeymap "n" "<leader>hn" ":HopNodes<cr>" "Nodes")
    (mkKeymap "n" "<leader>hh" ":HopPattern<cr>" "Pattern")
    (mkKeymap "n" "<leader>hv" ":HopVertical<cr>" "Vertical")
    (mkKeymap "n" "<leader>hw" ":HopWord<cr>" "Word")
  ];
  plugins.which-key.registrations = {
    # "<leader>h".name = "󰆾 Hop";
    "<leader>h".name = " Hop";
  };
}
