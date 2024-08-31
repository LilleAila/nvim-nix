{
  pkgs,
  mkRegistration,
  mkKeymap,
  lib,
  colorScheme,
  ...
}:
let
  c = lib.attrsets.mapAttrs (_: value: "#${value}") colorScheme.palette;
in
{
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
        hl_groups = {
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
          __raw = ''
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
    (mkKeymap "n" "<leader>ot" ":ObsidianTags<cr>" "Tags")
    (mkKeymap "n" "<leader>oC" ":ObsidianTOC<cr>" "Table of contents")

    # Editing
    (mkKeymap "n" "<leader>oT" ":ObsidianTemplate<cr>" "Insert template")
    (mkKeymap "n" "<leader>op" ":ObsidianPasteImg<cr>" "Paste image")
    (mkKeymap "n" "<leader>oc" ":ObsidianToggleCheckbox<cr>" "Toggle checkbox")

    (mkKeymap "n" "<leader>oz" ":ZenMode<cr>" "Zen mode")
  ];

  # Currently sets for all md files, but maybe do something like vault/**/*.md, but vim doesn't like the space in my current name :(
  extraConfigVim = ''
    augroup obsidian_markdown
      autocmd!
      autocmd BufRead,BufNewFile *.md setlocal conceallevel=2 linebreak
    augroup END
  '';

  # The nixvim module doesn't have all the required options
  extraPlugins = [ pkgs.vimPlugins.image-nvim ];

  extraConfigLua = # lua
    ''
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = false, -- It overlaps with the text above for some reason
            resolve_image_path = function(_, image_path, fallback)
              -- The document_path provided to the function doesn't work with obsidian for some reason
              -- local document_path = vim.fn.expand("%:p")
              local document_path = vim.api.nvim_buf_get_name(0)
                -- change this to whatever is your obsidian vault path
              if string.find(document_path, "Obsidian Vault") then
                -- maybe it'd be better to somehow use an absolute path, but it doesn't look like there's an easy way to do it `:h fnamemodify()` does not support that.
                -- this too
                return "~/Documents/Obsidian Vault/" .. image_path
              else
                return fallback(document_path, image_path)
              end
            end,
          },
        },
      })
    '';

  plugins.headlines = {
    enable = true;
    settings.markdown = {
      headline_highlights = [
        "Headline1"
        "Headline2"
        "Headline3"
        "Headline4"
        "Headline5"
        "Headline6"
      ];
      fat_headlines = true;

      bullets = [
        "󰲡"
        "󰲣"
        "󰲥"
        "󰲧"
        "󰲩"
        "󰲫"
      ];

      dash_string = "";
    };
  };

  highlight = {
    # Provided by headlines.nvim
    Headline1.fg = c.base0B;
    Headline1.bg = c.base01;
    Headline2.fg = c.base0D;
    Headline2.bg = c.base01;
    Headline3.fg = c.base0E;
    Headline3.bg = c.base01;
    Headline4.fg = c.base09;
    Headline4.bg = c.base01;
    Headline5.fg = c.base0C;
    Headline5.bg = c.base01;
    Headline6.fg = c.base08;
    Headline6.bg = c.base01;
    Quote.fg = c.base0A;
  };

  /*
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
  */

  plugins.zen-mode = {
    enable = true;
    settings = {
      window = {
        backdrop = 1;
        height = 1;
        width = 120;
        options = {
          signcolumn = "no";
          number = false;
          relativenumber = false;
          list = false;
          cursorline = false;
          cursorcolumn = false;
          foldcolumn = "0";
        };
      };
      plugins.kitty = {
        enabled = true;
        font = "+4";
      };
      plugins.options = {
        enabled = true;
        ruler = false;
        showcmd = false;
        laststatus = 0; # Hide status line
      };
    };
  };
}
