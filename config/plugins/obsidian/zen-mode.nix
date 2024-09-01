{ ... }:
{
  plugins.zen-mode = {
    enable = true;
    settings = {
      window = {
        backdrop = 1;
        height = 1;
        width = 120;
        options = {
          signcolumn = "no";
          number = false;
          relativenumber = false;
          list = false;
          cursorline = false;
          cursorcolumn = false;
          foldcolumn = "0";
        };
      };
      plugins.kitty = {
        enabled = true;
        font = "+4";
      };
      plugins.options = {
        enabled = true;
        ruler = false;
        showcmd = false;
        laststatus = 0; # Hide status line
      };
    };
  };
}
