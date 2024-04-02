{
  pkgs,
  colorScheme,
  ...
}: {
  imports = [
    ./ui
    ./lsp
    ./utils
    ./org
  ];

  extraPlugins = [
    {
      plugin = import ./colorscheme.nix {inherit pkgs;} {scheme = colorScheme;};
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];
}
