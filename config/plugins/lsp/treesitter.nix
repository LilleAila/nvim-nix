{
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    settings.indent.enable = false; # Breaks orgmode or something
    settings.highlight.disable = [
      "tex"
      "latex"
    ];
  };
}
