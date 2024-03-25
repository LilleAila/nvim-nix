{ mkKeymap, mkKeymapWithOpts, ... }:

{
	plugins.lsp = {
		enable = true;
		servers = {
			tsserver.enable = true;
			tailwindcss.enable = true;
			emmet_ls.enable = true;
			eslint.enable = true;
			lua-ls.enable = true;
			jsonls.enable = true;
			nil_ls.enable = true;
			rust-analyzer = {
				enable = true;
				# NOTE: These packages are installed in devshells.
				installCargo = false;
				installRustc = false;
				settings.check.command = "clippy";
			};
			hls.enable = true;
		};

		keymaps = {
			silent = true;
			diagnostic = {
				"<leader>k" = "goto_prev";
				"<leader>j" = "goto_next";
				"<leader>ll" = "open_float";
			};
			lspBuf = {
				"gd" = "definition";
				"<leader>ld" = "definition";
				"<C-leftmouse>" = "definition";

				"gD" = "implementation";
				"<leader>li" = "implementation";

				"<leader>lr" = "rename";
				"<F2>" = "rename";

				"<leader>la" = "code_action";
				"ca" = "code_action";

				"K" = "hover";
				"<leader>lk" = "hover";
			};
		};
	};

	# Add descriptions to which-key.
	# Items defined in keymaps will have their command as description by default
	plugins.which-key.registrations = {
		"<leader>l" = "LSP";
		"<leader>k" = "Previous diagnostic";
		"<leader>j" = "Next diagnostic";
		"<leader>ll" = "Line diagnostics";
		"<leader>ld" = "Definition";
		"<leader>li" = "Implementation";
		"<leader>lr" = "Rename";
		"<leader>la" = "Code actions";
		"<leader>lk" = "Hover";
	};

	keymaps = [
		(mkKeymap "n" "<leader>lR" ":LspRestart<cr>")
		(mkKeymap "n" "<leader>lI" ":LspInfo<cr>")
	];

	plugins.conform-nvim = {
		enable = true;
		formatOnSave = {
			lspFallback = true;
			timeoutMs = 500;
		};
		formattersByFt = {
			# NOTE: Formatters are also installed in devshells.
			html = [[
				"prettierd"
				"prettier"
			]];
			css = [[
				"prettierd"
				"prettier"
			]];
			javascript = [[
				"prettierd"
				"prettier"
			]];
			javascriptreact = [[
				"prettierd"
				"prettier"
			]];
			typescript = [[
				"prettierd"
				"prettier"
			]];
			python = [ "black" ];
			lua = [ "stylua" ];
			nix = [ "nixfmt" ];
			markdown = [[
				"prettierd"
				"prettier"
			]];
			rust = [ "rustfmt" ];
		};
	};
}
