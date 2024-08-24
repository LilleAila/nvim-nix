{ mkRegistration, mkKeymap, ... }:
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

      note_id_func = # lua
        ''
          function(title)
            local name = ""
            if title ~= nil and title ~= "" then
              name = title
            else
              -- Ask the user for a name
              name = vim.fn.input("Enter note name: ")
              if name == "" then
                -- If no name is given, generate a random one.
                for _ = 1, 5 do
                  name = name .. string.char(math.random(65, 90))
                end
              end
            end
            -- transform the name into a valid file name and append the date in ISO 9601 format
            local prefix = name:gsub(" ", "_"):lower():gsub("[^a-z0-9]", "")
            return prefix .. "-" .. tostring(os.date("!%Y%m%dT%H%M"))
          end
        '';
    };
  };

  plugins.which-key.settings.spec = [ (mkRegistration "<leader>o" "󱓧 Obsidian") ];
  # Keybinds with "" as an argument means that an empty title is being passed, then passed to the above name generating function
  keymaps = [
    # Note management
    (mkKeymap "n" "<leader>on" '':ObsidianNew ""<cr>'' "New note")
    (mkKeymap "n" "<leader>od" ":ObsidianToday<cr>" "Daily note")
    (mkKeymap "n" "<leader>oN" '':ObsidianNewFromTemplate ""<cr>'' "New from template")

    (mkKeymap "n" "<leader>oo" ":ObsidianQuickSwitch<cr>" "Open note")
    (mkKeymap "n" "<leader>os" ":ObsidianSearch<cr>" "Search notes")
    (mkKeymap "n" "<leader>oa" ":ObsidianOpen<cr>" "Open in app")
    (mkKeymap "n" "<leader>oD" ":ObsidianDailies<cr>" "Daily note history")

    # Links
    (mkKeymap "n" "<leader>ol" ":ObsidianLinks<cr>" "Links")
    (mkKeymap "n" "<leader>o<cr>" ":ObsidianFollowLink<cr>" "Follow link")
    (mkKeymap "x" "<leader>oe" '':ObsidianExtractNote ""<cr>'' "Extract note")
    (mkKeymap "x" "<leader>ol" ":ObsidianLink<cr>" "Link selection to note")
    (mkKeymap "n" "<leader>or" ":ObsidianRename<cr>" "Rename note")
    (mkKeymap "x" "<leader>on" '':ObsidianLinkNew ""<cr>'' "Create new note from selection") # This generates random names :(

    (mkKeymap "n" "<leader>ob" ":ObsidianBacklinks<cr>" "Backlinks")
    (mkKeymap "n" "<leader>ot" ":ObsidianTags<cr>" "Tags")
    (mkKeymap "n" "<leader>oC" ":ObsidianTOC<cr>" "Table of contents")

    # Editing
    (mkKeymap "n" "<leader>oT" ":ObsidianTemplate<cr>" "Insert template")
    (mkKeymap "n" "<leader>op" ":ObsidianPasteImg<cr>" "Paste image")
    (mkKeymap "n" "<leader>oc" ":ObsidianToggleCheckbox<cr>" "Toggle checkbox")
  ];

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
