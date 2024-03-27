{
  mkKeymap',
  mkKeymapWithOpts,
  ...
}: {
  keymaps = [
    # Indent without exiting visual mode
    (mkKeymap' "v" "<" "<gv")
    (mkKeymap' "v" ">" ">gv")

    # jk or kj to exit insert mode
    (mkKeymap' "i" "jk" "<Esc>")
    (mkKeymap' "i" "kj" "<Esc>")

    # vv to enter visual block mode
    (mkKeymap' "n" "vv" "<C-V>")

    # ; as an alias for :
    (mkKeymap' "n" ";" ":")

    # Buffer navigation (Configured through barbar keymap instead)
    # (mkKeymap' "n" "<Tab>" ":bnext<CR>")
    # (mkKeymap' "n" "<S-Tab>" ":bprevious<CR>")

    # Move lines, similar to move.nvim (but not as powerful)
    # TODO: set up move.nvim instead
    (mkKeymap' "n" "<C-S-j>" ":m +1<cr>")
    (mkKeymap' "n" "<C-S-k>" ":m -2<cr>") # For some reason -2 moves 1 line up
    (mkKeymap' "n" "<Down>" ":m +1<cr>") # Same commands but arrow keys
    (mkKeymap' "n" "<Up>" ":m -2<cr>")
  ];
}
