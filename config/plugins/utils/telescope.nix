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
      # https://github.com/nvim-telescope/telescope.nvim/issues/848
      # https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua

      # ivy-like layout
      layout_strategy = "bottom_pane";
      layout_config = {
        height = 0.4;
      };
      border = false;
      sorting_strategy = "ascending";

      # dropdown
      # results_title = false;
      # sorting_strategy = "ascending";
      # layout_strategy = "center";
      # layout_config = {
      #   preview_cutoff = 1;
      #   width = {
      #     __raw = ''
      #       function(_, max_columns, _)
      #         return math.min(max_columns, 80)
      #       end
      #     '';
      #   };
      #   height = {
      #     __raw = ''
      #       function(_, _, max_lines)
      #         return math.min(max_lines, 20)
      #       end
      #     '';
      #   };
      # };
      # border = true;
      # borderchars = {
      #   prompt = [
      #     "─"
      #     "│"
      #     " "
      #     "│"
      #     "╭"
      #     "╮"
      #     "│"
      #     "│"
      #   ];
      #   results = [
      #     "─"
      #     "│"
      #     "─"
      #     "│"
      #     "├"
      #     "┤"
      #     "╯"
      #     "╰"
      #   ];
      #   preview = [
      #     "─"
      #     "│"
      #     "─"
      #     "│"
      #     "╭"
      #     "╮"
      #     "╯"
      #     "╰"
      #   ];
      # };
      #
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
