{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope";
      };
      "<leader>fs" = {
        action = "live_grep";
        options.desc = "Grep";
      };
      "<leader>bb" = {
        action = "buffers";
        options.desc = "Buffers";
      };
      "<leader>fr" = {
        action = "oldfiles";
        options.desc = "Recent files";
      };
      # "<leader>fq" = {
      #   action = "quickfix";
      #   options.desc = "Quickfix";
      # };

      "<leader>fgb" = {
        action = "git_branches";
        options.desc = "Branches";
      };
      "<leader>fgf" = {
        action = "git_files";
        options.desc = "Files";
      };
      "<leader>fgs" = {
        action = "git_status";
        options.desc = "Status";
      };
    };
    settings.defaults = {
      mappings = {
        i = {
          "<esc>".__raw = ''
            function(...) return require("telescope.actions").close(...) end
          '';
          "<C-k>".__raw = ''
            function(...) return require("telescope.actions").move_selection_previous(...) end
          '';
          "<C-j>".__raw = ''
            function(...) return require("telescope.actions").move_selection_next(...) end
          '';
        };
      };
    };
  };
}
