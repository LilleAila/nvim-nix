{
  pkgs,
  inputs,
  colorScheme,
  mkKeymap,
  mkRegistration,
  ...
}:
{
  # This does not work for some reason.. probably the luarocks dependency stuff mentioned in the readme.
  # plugins.neorg = {
  #   enable = true;
  # };

  imports = [
    # ./molten.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    orgmode
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-bullets.nvim";
      src = inputs.plugin-org-bullets;
    })
  ];

  plugins.cmp.settings.sources = [ { name = "orgmode"; } ];

  # Set conceallevel locally
  # TODO: Change the "change tab" keybinding, because it conflicts with the toggle-fold keybind in org mode
  files."ftplugin/org.lua" = {
    opts = {
      conceallevel = 2;
      concealcursor = "nc";
    };
  };

  extraConfigLua =
    let
      c = colorScheme.palette;
    in
    # lua
    ''
      -- vim.cmd("language en_US.utf8") -- doesn't work (sometimes)?? idk
      require("orgmode").setup({
        org_agenda_files = { "~/org/*", "./notes.org" }, -- Add both global and project-specific notes to the agenda
        -- Remember to refresh agenda with `r` when changing directories.
        org_default_notes_file = "~/org/notes.org",
        org_startup_folded = "overview",

        org_todo_keywords = { "TODO", "NEXT", "|", "DONE", },
        org_todo_repeat_to_state = "TODO",
        org_todo_keyword_faces = {
          TODO = ":foreground #${c.base00} :background #${c.base0A} :weight bold",
          NEXT = ":foreground #${c.base00} :background #${c.base09} :weight bold :slant italic",
          DONE = ":foreground #${c.base00} :background #${c.base0B}",
        },
        org_capture_templates = {
          -- Global
          t = {
            description = "Task",
            template = "* TODO %?",
          },
          n = {
            description = "Note",
            template = "* %?\n %U",
          },

          -- Project-specific
          T = {
            description = "Local task",
            template = "* TODO %?",
            target = "./notes.org",
          },
          N = {
            description = "Local note",
            template = "* %?",
            target = "./notes.org",
          },
          P = {
            description = "Local project task",
            template = "* TODO %?\n %U\n %a\n",
            target = "./notes.org",
          },
          p = {
            description = "Local project note",
            template = "* %?\n %U\n %a\n",
            target = "./notes.org",
          },
        },

        org_archive_location = "%s_archive::",
        org_hide_leading_stars = false,
        org_hide_emphasis_markers = false,
        org_ellipsis = "...", -- Text shown when headline is folded
        org_log_done = "time",
        org_log_into_drawer = nil,
        org_highlight_latex_and_related = "entities",
        org_startup_indented = true,
        org_adapt_indentation = true,
        org_time_stamp_rounding_minutes = 5,
        org_blank_before_new_entry = {
          heading = true,
          plain_list_item = false,
        },
        org_babel_default_header_args = {
          [":tangle"] = "no",
          [":noweb"] = "no"
        },
        calendar_week_start_day = 1, -- Monday

        win_split_mode = "auto",
        win_border = "rounded",
      })
      require("orgmode").setup_ts_grammar()
      require("org-bullets").setup()
    '';

  plugins.which-key.settings.spec = [ (mkRegistration "<leader>o" " Org") ];

  keymaps = [
    (mkKeymap "n" "<leader>on" ":e ./notes.org<cr>" "Edit local notes")
    (mkKeymap "n" "<leader>oN" ":e ~/org/notes.org<cr>" "Edit global notes")
  ];
}
