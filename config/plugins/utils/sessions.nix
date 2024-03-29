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
      # useGitBranch = true; # Causes problems, see [#268](https://github.com/rmagatti/auto-session/issues/268)
    };
  };

  keymaps = [
    (mkKeymap "n" "<leader>ss" ":SessionRestore<cr>" "Restore Session")
    (mkKeymap "n" "<leader>sa" ":SessionSave<cr>" "Save Session")
    (mkKeymap "n" "<leader>sr" ":SessionDelete<cr>" "Delete Session")
  ];
}
