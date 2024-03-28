{
  mkKeymap,
  mkKeymap',
  ...
}: {
  plugins.toggleterm = {
    enable = true;
    size = ''
      function(term)
        if term.direction == "horizontal" then
          return 15
      elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end
    '';
    hideNumbers = true;
    shadeTerminals = false;
    startInInsert = true;
    terminalMappings = true;
    persistMode = true;
    insertMappings = false;
    closeOnExit = true;
    shell = "zsh";
    direction = "horizontal";
    autoScroll = true;
    floatOpts = {
      border = "rounded";
      winblend = 0;
    };
    winbar.enabled = false;
  };

  keymaps = [
    (mkKeymap "n" "<leader>mt" ":ToggleTerm direction=float<cr>" "Float")
    (mkKeymap "n" "<leader>mh" ":ToggleTerm direction=horizontal<cr>" "Horizontal")
    (mkKeymap "n" "<leader>mv" ":ToggleTerm direction=vertical<cr>" "Vertical")
    # Exit terminal mode
    (mkKeymap' "t" "<Esc>" "<C-\\><C-n>")
    (mkKeymap' "t" "jk" "<C-\\><C-n>")
    (mkKeymap' "t" "kj" "<C-\\><C-n>")
  ];
}
