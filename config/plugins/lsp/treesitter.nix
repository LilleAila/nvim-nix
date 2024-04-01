{
  plugins.treesitter = {
    enable = true;
    indent = true;
    nixvimInjections = true;
    disabledLanguages = [
      "tex"
      "latex"
    ];
  };
}
