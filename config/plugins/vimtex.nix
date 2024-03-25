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
			view_enabled = 1;
			syntax_conceal_enable = 1;
		};
	};

	# Detect OS and choose PDF viewer accordingly
	extraConfigLua = /*lua*/ ''
	local g = vim.g
	local platform = vim.loop.os_uname().sysname
	if platform == "Darwin" then
		g.vimtex_view_method = "skim"
		g.vimtex_view_skim_activate = 1
	elseif platform == "Linux" then
		g.vimtex_view_method = "zathura"
		g.vimtex_view_zathura_activate = 1
	else
		g.vimtex_view_method = "generic"
	end
	'';

	keymaps = [
		(mkKeymap "n" "<leader>xc" ":VimtexCompile<cr>")
		(mkKeymap "n" "<leader>xv" ":VimtexView<cr>")
		(mkKeymap "n" "<leader>xs" ":VimtexStop<cr>")
		(mkKeymap "n" "<leader>xe" ":VimtexErrors<cr>")
		(mkKeymap "n" "<leader>xS" ":VimtexStatus<cr>")
		(mkKeymap "n" "<leader>xi" ":VimtexInfo<cr>")
		(mkKeymap "n" "<leader>xC" ":VimtexClean<cr>")
		(mkKeymap "n" "<leader>xo" ":VimtexCompileSS<cr>")
	];

	plugins.which-key.registrations = {
		"<leader>x" = "LaTeX";
	};
}
