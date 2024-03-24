let
  mkKeymap = mode: key: action: { inherit mode key action; };
  mkKeymapWithOpts =
    mode: key: action: opts:
    (mkKeymap mode key action) // { options = opts; };
in
{

	keymaps = [
		# Write with <C-s>
		(mkKeymap "n" "<C-s>" ":w<cr>")

		# Indent without exiting visual mode
    (mkKeymap "v" "<" "<gv")
    (mkKeymap "v" ">" ">gv")

		# jk or kj to exit insert mode
    (mkKeymap "i" "jk" "<Esc>")
    (mkKeymap "i" "kj" "<Esc>")

		# vv to enter visual block mode
    (mkKeymap "n" "vv" "<C-V>")

		# ; as an alias for :
    (mkKeymap "n" ";" ":")

		# Buffer navigation
    (mkKeymap "n" "<Tab>" ":bnext<CR>")
    (mkKeymap "n" "<S-Tab>" ":bprevious<CR>")
	];
}
