{...}: {
  imports = [
    ./oil.nix
    ./sessions.nix
    ./telescope.nix
    ./guess-indent.nix
    ./hop.nix
    ./toggleterm.nix
    ./img-clip.nix
    ./move.nix
    ./mini.nix
    ./luasnip
  ];

  plugins = {
    nvim-autopairs.enable = true;
    comment-nvim = {
      enable = true;
      padding = true;
    };
    direnv.enable = true;
  };

  plugins.luasnip = {
    enable = true;
    extraConfig = {
      update_events = "TextChanged,TextChangedI";
      store_selection_keys = "<Tab>";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      history = false;
    };
    # fromLua = [
    #   {
    #     path = ./luasnip;
    #     lazyLoad = true;
    #   }
    # ];
    snippets.all.snippets = [
      {
        trig = "hi";
        text = "Hello, World!";
      }
    ];
  };
}
