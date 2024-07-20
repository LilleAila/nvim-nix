{ mkKeymap, mkKeymap', ... }:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = ''
        function(term)
          if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end
      '';
      winbar.enabled = false;
      floatOpts = {
        border = "rounded";
        winblend = 0;
      };
      autoScroll = true;
      hideNumbers = true;
      shadeTerminals = false;
      startInInsert = true;
      terminalMappings = true;
      persistMode = true;
      insertMappings = false;
      closeOnExit = true;
      shell = "zsh";
      direction = "horizontal";
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>tt" ":ToggleTerm direction=float<cr>" "Float")
    (mkKeymap "n" "<leader>th" ":ToggleTerm direction=horizontal<cr>" "Horizontal")
    (mkKeymap "n" "<leader>tv" ":ToggleTerm direction=vertical<cr>" "Vertical")
    # Exit terminal mode
    (mkKeymap' "t" "<Esc>" "<C-\\><C-n>")
  ];
}
