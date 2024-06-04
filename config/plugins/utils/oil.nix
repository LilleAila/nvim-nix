{mkKeymap, ...}: {
  plugins.oil = {
    enable = true;
    settings = {
      keymaps = {
        "g?" = "actions.show_help";
        "<CR>" = "actions.select";
        "<C-s>" = "actions.select_vsplit";
        "<C-h>" = "actions.select_split";
        "<C-t>" = "actions.select_tab";
        "<C-p>" = "actions.preview";
        "<C-c>" = "actions.close";
        "<C-l>" = "actions.refresh";
        "-" = "actions.parent";
        "_" = "actions.open_cwd";
        "`" = "actions.cd";
        "~" = "actions.tcd";
        "gs" = "actions.change_sort";
        "gx" = "actions.open_external";
        "g." = "actions.toggle_hidden";
        "g\\" = "actions.toggle_trash";
      };

      default_file_explorer = true; # Replace netrw
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      buf_options = {
        bufhidden = "hide";
        buflisted = false;
      };
      view_options = {
        show_hidden = false;
        # Hide .git folders
        is_always_hidden =
          /*
          lua
          */
          ''
            function(name, bufnr)
            	if name == ".git" then
            		return true
            	else
            		return false
            	end
            end
          '';
      };
      win_options = {
        wrap = false;
        signcolumn = "no";
        cursorcolumn = false;
        foldcolumn = "0";
        spell = false;
        list = false;
        conceallevel = 3;
        concealcursor = "nvic";
      };
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>fe" ":Oil<cr>" "Oil")
  ];
}
