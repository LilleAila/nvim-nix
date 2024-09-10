{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = [ "statix" ];
      tex = [ "chktex" ];
    };
  };

  autoCmd = [
    {
      command = ''lua require("lint").try_lint()'';
      event = [
        "BufWritePost"
      ];
    }
  ];
}
