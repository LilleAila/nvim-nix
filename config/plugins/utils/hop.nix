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
    (mkKeymap "n" "<leader><space>" ":HopWord<cr>" "Hop")
  ];
}
