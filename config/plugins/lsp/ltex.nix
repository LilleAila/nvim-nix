{
  plugins.lsp.servers.ltex = {
    enable = true;
    autostart = false; # Manually start with :LspStart because i use too many languages and this is set up specifically for french
    settings = {
      enabled = [
        "markdown"
        "latex"
      ];
      checkFrequency = "edit";
      completionEnabled = false; # neovim spell for completion
      language = "fr";
      statusBarItem = true;
    };
  };
}
