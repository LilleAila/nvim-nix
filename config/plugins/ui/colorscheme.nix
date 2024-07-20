{
  pkgs,
  colorScheme,
  lib,
  ...
}:
let
  c = lib.attrsets.mapAttrs (_: value: "#${value}") colorScheme.palette;
in
{
  # TODO: recolor tokyo night instead of doing this shit
  extraPlugins = [
    {
      plugin = import ../colorscheme.nix { inherit pkgs; } { scheme = colorScheme; };
      config = "colorscheme nix-${colorScheme.slug}";
    }
  ];

  highlight = {
    winSeparator.fg = c.base05;
    CursorLineNr.bg = c.base0A;

    # Treesitter and LSP
    Identifier.fg = c.base0D;
    "@lsp.type.property".fg = c.base0C;
    "@variable.member".fg = c.base09;
    "@boolean".fg = c.base08;
    "@module".fg = c.base08;
    Comment.fg = c.base04;
    DiagnosticUnnecessary.fg = c.base04;
    "@markup.link".fg = c.base0E;
    "@markup.link.label".fg = c.base0D;
    "@markup.heading".fg = c.base09;
    "@markup.raw.block".fg = c.base0C;
    "@markup.math".fg = c.base0C;

    WhichKeyFloat.fg = c.base05;
    WhichKeyFloat.bg = c.base01;
    WhichKeyGroup.fg = c.base0B;
  };
}
