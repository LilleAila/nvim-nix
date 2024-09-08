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
      command = ''require("lint").try_lint()'';
      event = [
        "BufWritePost"
      ];
    }
  ];
}
