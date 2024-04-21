{
  mkKeymap,
  mkKeymapWithOpts,
  ...
}: {
  plugins.vimtex = {
    enable = true;
    texlivePackage = null; # Install in nix shell
    settings = {
      compiler_method = "latexmk";
      compiler_latexmk_engines = {
        "_" = "-pdf";
        "pdf_escaped" = "-pdf -pdflatex=\"pdflatex -shell-escape %O %S\"";
      };
      view_enabled = 1;
      syntax_conceal_enable = 1;
    };
  };

  # Enable conceal in LaTeX files
  files."ftplugin/tex.lua" = {
    options = {
      conceallevel = 2;
      concealcursor = "nc";
    };
  };

  # Detect OS and choose PDF viewer accordingly
  extraConfigLua =
    /*
    lua
    */
    ''
      local g = vim.g
      local platform = vim.loop.os_uname().sysname
      if platform == "Darwin" then
      	g.vimtex_view_method = "skim"
      	g.vimtex_view_skim_activate = 1
      elseif platform == "Linux" then
      	g.vimtex_view_method = "zathura"
      	g.vimtex_view_zathura_activate = 1
      else
      	g.vimtex_view_method = "generic"
      end
    '';

  keymaps = [
    (mkKeymap "n" "<leader>lxc" ":VimtexCompile<cr>" "Compile")
    (mkKeymap "n" "<leader>lxv" ":VimtexView<cr>" "View")
    (mkKeymap "n" "<leader>lxs" ":VimtexStop<cr>" "Stop")
    (mkKeymap "n" "<leader>lxe" ":VimtexErrors<cr>" "Errors")
    (mkKeymap "n" "<leader>lxS" ":VimtexStatus<cr>" "Status")
    (mkKeymap "n" "<leader>lxi" ":VimtexInfo<cr>" "Info")
    (mkKeymap "n" "<leader>lxC" ":VimtexClean<cr>" "Clean")
    (mkKeymap "n" "<leader>lxo" ":VimtexCompileSS<cr>" "Compile Once")
  ];
}
