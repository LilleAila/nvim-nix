{
  pkgs,
  colorScheme,
  ...
}: {
  imports = [
    ./ui
    ./lsp
    ./utils
  ];

  extraPlugins = [
    {
      plugin = import ./colorscheme.nix {inherit pkgs;} {scheme = colorScheme;};
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];
}
