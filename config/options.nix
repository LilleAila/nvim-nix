{
  opts = {
    encoding = "UTF-8";
    fileencoding = "utf-8";
    mousemoveevent = true;
    hidden = true;
    ch = 0;
    pumheight = 10;
    winminwidth = 10;
    splitbelow = true;
    splitright = true;
    list = true;
    termguicolors = true;
    showtabline = 3;
    tabline = " ";
    showmode = false;
    backup = false;
    number = true;
    relativenumber = true;
    numberwidth = 3;
    ruler = false;
    writebackup = false;
    updatetime = 250;
    timeoutlen = 100;
    hlsearch = true;
    incsearch = true;
    ignorecase = true;
    smartcase = true;
    scrolloff = 0;
    sidescrolloff = 5;
    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;
    mouse = "a";
    cursorline = true;
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;
    signcolumn = "yes";
    laststatus = 0;
    shadafile = "NONE";
    swapfile = false;
    undofile = true;
    undolevels = 10000;
  };

  globals = {
    mapleader = " ";
    tex_flavor = "latex";
    code_action_menu_window_border = "single";
  };

  autoCmd = [
    # remove trailing whitespace on save
    {
      event = "BufWritePre";
      pattern = "*";
      command = "silent! %s/\\s\\+$//e";
    }
    # absolute line numbers in insert mode, relative otherwise
    {
      event = "InsertEnter";
      pattern = "*";
      command = "set number norelativenumber";
    }
    {
      event = "InsertLeave";
      pattern = "*";
      command = "set number relativenumber";
    }
  ];

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };
}
