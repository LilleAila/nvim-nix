{
	plugins = {
		lsp = {
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
					# NOTE: These things are installed in devshells.
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
				};
				lspBuf = {
					gd = "definition";
					"<C-leftmouse>" = "definition";
					"<F2>" = "rename";
					gD = "implementation";
					ca = "code_action";
					K = "hover";
				};
			};
		};

		conform-nvim = {
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
	};
}
