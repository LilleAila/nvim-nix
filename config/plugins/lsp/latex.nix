{
  pkgs,
  inputs,
  mkKeymap,
  ...
}:
{
  plugins.lsp.servers.texlab = {
    enable = true;
    package = null;
    settings.texlab = {
      # build = "_G.TeXMagicBuildConfig";
      build = {
        executable = "latexmk";
        args = [
          "-pdflua"
          "-synctex=1"
          "-shell-escape"
          "%f"
        ];
        forwardSearchAfter = true;
        onSave = true;
      };

      # Done through nvim-lint instead of through texlab
      chktex = {
        onOpenAndSave = false;
        onEdit = false;
      };

      latexFormatter = "latexindent";

      forwardSearch = {
        # Sioyek crashes for some reason. First launch after removing one of ~/.local/sharea/sioyek/{local,shared}.db works, next time it crashes /shrug
        /*
          executable = "sioyek";
          args = [
            "--reuse-window"
            "--execute-command"
            "toggle_synctex"
            "--inverse-search"
            "texlab inverse-search -i \"%%1\" -l %%2"
            "--forward-search-file"
            "%f" # tex file
            "--forward-search-line"
            "%l" # line number
            "%p" # pdf file
          ];
        */
        executable = "zathura";
        args = [
          "--synctex-forward"
          "%l:1:%f"
          "%p"
          "--synctex-editor-command"
          "texlab inverse-search -i %%{input} -l %%{line}"
        ];
      };
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>lxb" ":TexlabBuild<cr>" "Build")
    (mkKeymap "n" "<leader>lxs" ":TexlabCancelBuild<cr>" "Stop build")
    (mkKeymap "n" "<leader>lxc" ":TexlabCleanArtifacts<cr>" "Clean artifacts")
    (mkKeymap "n" "<leader>lxC" ":TexlabCleanAuxilary<cr>" "Clean auxilary")
    (mkKeymap "n" "<leader>lxf" ":TexlabForward<cr>" "Forward search")
    (mkKeymap "n" "<leader>lxr" ":TexlabChangeEnvironment<cr>" "Rename environment")
  ];

  # works but not needed
  /*
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "texmagic.nvim";
        src = inputs.plugin-texmagic;
      })
    ];

    extraConfigLuaPre = # lua
      ''
        require("texmagic").setup({
          engines = {
            lualatex = {
              executable = "latexmk",
              args = {

              },
              isContinuous = true,
            },
          },
        })
      '';
  */
}
