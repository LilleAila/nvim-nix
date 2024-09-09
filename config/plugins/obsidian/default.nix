{
  pkgs,
  mkRegistration,
  mkKeymap,
  lib,
  colorScheme,
  inputs,
  ...
}:
{
  imports = [
    ./obsidian-bridge.nix
    ./image.nix
    ./markdown.nix
    ./zen-mode.nix
    ./todos.nix
  ];

  plugins.obsidian = {
    enable = true;
    settings = {
      picker.name = "telescope.nvim";
      templates.subdir = "Templates";
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
      mappings = { };

      ui = {
        enable = true;
        bullets.char = "";
        # external_link_icon.char = "";
        checkboxes = {
          " " = {
            char = "󰄱";
            hl_group = "ObsidianTodo";
          };
          "x" = {
            char = "󰄲";
            hl_group = "ObsidianDone";
          };
          ">" = {
            char = "󰛂";
            hl_group = "ObsidianRightArrow";
          };
        };
        hl_groups =
          let
            c = lib.attrsets.mapAttrs (_: value: "#${value}") colorScheme.palette;
          in
          {
            ObsidianTodo.fg = c.base0A;
            ObsidianDone.fg = c.base0B;
            ObsidianRightArrow.fg = c.base09;
            # ObsidianTilde.fg = c.base0F;
            # ObsidianImportant.fg = c.base08;
            ObsidianBullet.fg = c.base0D;
            ObsidianRefText.fg = c.base0E;
            ObsidianExtLinkIcon.fg = c.base0E;
            ObsidianTag.fg = c.base0C;
            ObsidianBlockID.fg = c.base0C;
            ObsidianHighlightText.bg = c.base0A;
            ObsidianHighlightText.fg = c.base01;
          };
      };

      note_id_func = # lua
        ''
          function(title)
            local name = ""
            if title ~= nil then
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
            -- transform the name into a valid file name and append the date in ISO 8601 format
            local suffix = name:gsub(" ", "-"):lower():gsub("[^a-z0-9-æøå]", "")
            return tostring(os.date("!%Y%m%dT%H%M")) .. "-" .. suffix
          end
        '';

      attachments.img_folder = "Assets";
      # This is only for the prefix of the name, not the entire name. afaik, there is no way to set a suffix
      image_name_func = # lua
        ''
          function()
            return tostring(os.date("!%Y%m%dT%H%M")) .. "-"
          end
        '';

      follow_url_func = # lua
        ''
          function(url)
            -- vim.fn.jobstart({"xdg-open", url})
            vim.ui.open(url)
          end
        '';

      follow_img_func = # lua
        {
          # This is not defined as an option, so has to be declared manually: https://github.com/nix-community/nixvim/blob/ee6ee48bbe1ffa88fd4b2af7d68ab0315bc817f0/lib/utils.nix#L112
          __raw = # lua
            ''
              function(img)
                -- For some reason this is the only thing that works /shrug
                local full_path = "$HOME/Documents/Obsidian\\\\ Vault/" .. img
                vim.cmd([[silent exec "!xdg-open ]] .. full_path .. [["]])
              end
            '';
        };
    };
  };

  plugins.which-key.settings.spec = [ (mkRegistration "<leader>o" "󱓧 Obsidian") ];
  keymaps = [
    # Note management
    (mkKeymap "n" "<leader>on" ":ObsidianNew<cr>" "New note")
    (mkKeymap "n" "<leader>od" ":ObsidianToday<cr>" "Daily note")
    (mkKeymap "n" "<leader>oN" ":ObsidianNewFromTemplate<cr>" "New from template")

    (mkKeymap "n" "<leader>oo" ":ObsidianQuickSwitch<cr>" "Open note")
    (mkKeymap "n" "<leader>os" ":ObsidianSearch<cr>" "Search notes")
    (mkKeymap "n" "<leader>oa" ":ObsidianOpen<cr>" "Open in app")
    (mkKeymap "n" "<leader>oD" ":ObsidianDailies<cr>" "Daily note history")

    # Links
    (mkKeymap "n" "<leader>ol" ":ObsidianLinks<cr>" "Links")
    (mkKeymap "n" "<leader>o<cr>" ":ObsidianFollowLink<cr>" "Follow link")
    (mkKeymap "x" "<leader>oe" ":ObsidianExtractNote<cr>" "Extract note")
    (mkKeymap "x" "<leader>ol" ":ObsidianLink<cr>" "Link selection to note")
    (mkKeymap "n" "<leader>or" ":ObsidianRename<cr>" "Rename note")
    (mkKeymap "x" "<leader>on" ":ObsidianLinkNew<cr>" "Create new note from selection") # This generates random names :(

    (mkKeymap "n" "<leader>ob" ":ObsidianBacklinks<cr>" "Backlinks")
    (mkKeymap "n" "<leader>oT" ":ObsidianTags<cr>" "Tags")
    (mkKeymap "n" "<leader>oC" ":ObsidianTOC<cr>" "Table of contents")

    # Editing
    (mkKeymap "n" "<leader>oi" ":ObsidianTemplate<cr>" "Insert template")
    (mkKeymap "n" "<leader>op" ":ObsidianPasteImg<cr>" "Paste image")
    (mkKeymap "n" "<leader>oc" ":ObsidianToggleCheckbox<cr>" "Toggle checkbox")

    (mkKeymap "n" "<leader>oz" ":ZenMode<cr>" "Zen mode")
  ];
}
