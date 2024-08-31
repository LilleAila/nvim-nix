{
  mkKeymap,
  colorScheme,
  lib,
  ...
}:
let
  p = colorScheme.palette;
  c = lib.attrsets.mapAttrs (_: value: "#${value}") p;
in
{
  plugins.mini = {
    enable = true;
    modules = {
      # Enabling with default options
      align = { };
      cursorword = { };
      files = { };
      diff = { };
      git = { };
      hipatterns.highlighters =
        let
          mkPattern = pattern: "%f[%w]()${pattern}()%f[%W]";
          mkHi = pattern: group: {
            inherit group;
            pattern = mkPattern pattern;
          };
        in
        {
          todo = mkHi "TODO" "MiniHipatternsTodo";
          note = mkHi "NOTE" "MiniHipatternsNote";
          fixme = mkHi "FIXME" "miniHipatternsFixme";
        }
        // lib.attrsets.mapAttrs (name: _: {
          pattern = mkPattern name;
          group = name;
        }) c;
      indentscope = { };
      # jump2d = { }; # TODO: configure as alternative to hop.nvim
      # move = { }; # TODO: configure as alternative to move.nvim
      notify = { };
      operators = { }; # g= to evaluate text
      # pairs = { }; # TODO: maybe configure (for nix double single quote)
      # sessions = { }; # TODO: configure as alternative to auto-session.nvim
      starter = { };
      # statusline = { }; # TODO: configure as alternative to lualine.nvim
      surround.mappings = {
        add = "sa";
        delete = "sd";
        find = "sf";
        find_left = "sF";
        highlight = "sh";
        replace = "sr";
        update_n_lines = "sn";
        suffix_last = "l";
        suffix_next = "n";
      };
      # tabline = { }; # TODO: configure as alternative to barbar.nvim
      trailspace = { };
      visits = { };
    };
  };

  highlight =
    {
      MiniDiffOverAdd.fg = c.base0B;
      MiniDiffOverDelete.fg = c.base08;
      MiniDiffOverChange.fg = c.base0D;
      MiniDiffOverContext.fg = c.base05;
      MiniDiffSignDelete.fg = c.base08;
      MiniDiffSignChange.fg = c.base0D;
      MiniDiffSignAdd.fg = c.base0B;
      MiniHipatternsTodo = {
        bg = c.base0A;
        fg = c.base01;
      };
      MiniHipatternsNote = {
        bg = c.base0A;
        fg = c.base01;
      };
      miniHipatternsFixme = {
        bg = c.base09;
        fg = c.base01;
      };
    }
    // lib.attrsets.mapAttrs (_: value: { fg = value; }) c
    // {
      base00.bg = c.base00;
      base00.fg = c.base05;
      base01.bg = c.base01;
      base01.fg = c.base05;
      base02.bg = c.base02;
      base02.fg = c.base05;
      base03.bg = c.base03;
      base03.fg = c.base06;
    };

  keymaps = [ (mkKeymap "n" "<leader>fm" ":lua MiniFiles.open()<cr>" "Mini-files") ];
}
