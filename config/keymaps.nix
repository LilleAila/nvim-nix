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
    # (mkKeymap' "i" "jk" "<Esc>")
    # (mkKeymap' "i" "kj" "<Esc>")

    # vv to enter visual block mode
    (mkKeymap' "n" "vv" "<C-V>")

    # ; as an alias for :
    (mkKeymap' "n" ";" ":")

    # Buffer navigation (Configured through barbar keymap instead)
    # (mkKeymap' "n" "<Tab>" ":bnext<CR>")
    # (mkKeymap' "n" "<S-Tab>" ":bprevious<CR>")
  ];
}
