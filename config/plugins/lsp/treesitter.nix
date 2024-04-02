{
  plugins.treesitter = {
    enable = true;
    indent = false; # Breaks orgmore or something
    nixvimInjections = true;
    disabledLanguages = [
      "tex"
      "latex"
    ];
  };
}
