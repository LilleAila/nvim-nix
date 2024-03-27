{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
    keymapsSilent = true;
    keymaps = {
      "<leader>tt" = {
        action = "find_files";
        desc = "Files";
      };
      "<leader>ts" = {
        action = "live_grep";
        desc = "Grep";
      };
      "<leader>tb" = {
        action = "buffers";
        desc = "Buffers";
      };
      "<leader>tr" = {
        action = "oldfiles";
        desc = "Recent files";
      };
      "<leader>tq" = {
        action = "quickfix";
        desc = "Quickfix";
      };

      "<leader>tgb" = {
        action = "git_branches";
        desc = "Branches";
      };
      "<leader>tgf" = {
        action = "git_files";
        desc = "Files";
      };
      "<leader>tgs" = {
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
