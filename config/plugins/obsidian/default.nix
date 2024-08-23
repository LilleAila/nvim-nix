{ colorScheme, ... }:
{
  plugins.obsidian = {
    enable = true;
    settings = {
      picker.name = "telescope.nvim";
      templates.subdir = "Templates";
      attachments.img_folder = "Assets";
      notes_subdir = "Notes";
      new_notes_location = "notes_subdir";
      workspaces = [
        {
          name = "personal";
          path = "~/Documents/Obsidian\ Vault";
        }
      ];
      daily_notes = {
        date_format = "%Y-%m-%d";
        folder = "Daily";
      };
      completion = {
        min_chars = 0;
        nvim_cmp = true;
      };
      # Unbind the default ones. Maybe add to <leader>o in the future
      # https://nix-community.github.io/nixvim/plugins/obsidian/settings/mappings/index.html
      mappings = { };
      ui.enable = true;
    };
  };

  files."ftplugin/md.lua" = {
    opts = {
      conceallevel = 2;
      concealcursor = "nc";
    };
  };

  plugins.image = {
    enable = true;
    backend = "kitty";
  };

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
}
