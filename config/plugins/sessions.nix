{mkKeymap, ...}: {
  plugins.auto-session = {
    enable = true;
    # :SessionRestore, :SessionSave
    autoRestore.enabled = false; # Only when `nvim` with no args
    autoSave.enabled = true;
    autoSession = {
      enabled = true;
      enableLastSession = true;
      createEnabled = true;
      useGitBranch = true;
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>sr" ":SessionRestore<cr>" "Restore Session")
    (mkKeymap "n" "<leader>ss" ":SessionSave<cr>" "Save Session")
    (mkKeymap "n" "<leader>sd" ":SessionDelete<cr>" "Delete Session")
  ];

  plugins.which-key.registrations = {
    "<leader>s" = "Sessions";
  };
}
