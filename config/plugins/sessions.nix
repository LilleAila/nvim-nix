{ mkKeymap, ... }:

{
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
		(mkKeymap "n" "<leader>sr" ":SessionRestore<cr>")
		(mkKeymap "n" "<leader>ss" ":SessionSave<cr>")
		(mkKeymap "n" "<leader>sd" ":SessionDelete<cr>")
	];

	plugins.which-key.registrations = {
		"<leader>s" = "Sessions";
	};
}
