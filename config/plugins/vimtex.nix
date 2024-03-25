{ mkKeymap, mkKeymapWithOpts, ... }:

{
	plugins.vimtex = {
		enable = true;
		texlivePackage = null; # Install in nix shell
		settings = {
			compiler_method = "latexmk";
			compiler_latexmk_engines = {
				"_" = "-pdf";
				"pdf_escaped" = "-pdf -pdflatex=\"pdflatex -shell-escape %O %S\"";
			};
			view_method = "zathura"; # TODO: make work on different os
			view_enabled = 1;
			syntax_conceal_enable = 1;
		};
	};

	keymaps = [
		(mkKeymap "n" "<leader>lc" ":VimtexCompile<cr>")
		(mkKeymap "n" "<leader>lv" ":VimtexView<cr>")
		(mkKeymap "n" "<leader>ls" ":VimtexStop<cr>")
		(mkKeymap "n" "<leader>le" ":VimtexErrors<cr>")
		(mkKeymap "n" "<leader>lS" ":VimtexStatus<cr>")
		(mkKeymap "n" "<leader>li" ":VimtexInfo<cr>")
		(mkKeymap "n" "<leader>lC" ":VimtexClean<cr>")
		(mkKeymap "n" "<leader>lo" ":VimtexCompileSS<cr>")
	];

	plugins.which-key.registrations = {
		"<leader>l" = "LaTeX";
	};
}
