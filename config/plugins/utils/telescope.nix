{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
    keymapsSilent = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        desc = "Telescope";
      };
      "<leader>fs" = {
        action = "live_grep";
        desc = "Grep";
      };
      "<leader>fb" = {
        action = "buffers";
        desc = "Buffers";
      };
      "<leader>fr" = {
        action = "oldfiles";
        desc = "Recent files";
      };
      # "<leader>fq" = {
      #   action = "quickfix";
      #   desc = "Quickfix";
      # };

      "<leader>fgb" = {
        action = "git_branches";
        desc = "Branches";
      };
      "<leader>fgf" = {
        action = "git_files";
        desc = "Files";
      };
      "<leader>fgs" = {
        action = "git_status";
        desc = "Status";
      };
    };
    defaults = {
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
