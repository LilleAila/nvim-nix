{ colorScheme, lib, ... }:
{
  # Currently sets for all md files, but maybe do something like vault/**/*.md, but vim doesn't like the space in my current name :(
  extraConfigVim = ''
    augroup obsidian_markdown
      autocmd!
      autocmd BufRead,BufNewFile *.md setlocal conceallevel=2 linebreak shiftwidth=2 spell
    augroup END
  '';

  plugins.headlines = {
    enable = true;
    settings.markdown = {
      headline_highlights = [
        "Headline1"
        "Headline2"
        "Headline3"
        "Headline4"
        "Headline5"
        "Headline6"
      ];
      fat_headlines = true;

      bullets = [
        "󰲡"
        "󰲣"
        "󰲥"
        "󰲧"
        "󰲩"
        "󰲫"
      ];

      dash_string = "";
    };
  };

  highlight =
    let
      c = lib.attrsets.mapAttrs (_: value: "#${value}") colorScheme.palette;
    in
    {
      # Provided by headlines.nvim
      Headline1.fg = c.base0B;
      Headline1.bg = c.base01;
      Headline2.fg = c.base0D;
      Headline2.bg = c.base01;
      Headline3.fg = c.base0E;
      Headline3.bg = c.base01;
      Headline4.fg = c.base09;
      Headline4.bg = c.base01;
      Headline5.fg = c.base0C;
      Headline5.bg = c.base01;
      Headline6.fg = c.base08;
      Headline6.bg = c.base01;
      Quote.fg = c.base0A;
    };

  /*
    plugins.markview = {
      enable = true;
      settings = {
        hybrid_modes = [
          "i"
          "r"
        ];
        mode = [
          "n"
          "x"
        ];
        buf_ignore = [ "nofile" ];
      };
    };
  */

}
