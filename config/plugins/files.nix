{ mkKeymap, ... }:

{
	plugins.oil = {
		enable = true;
		keymaps = {
			"g?" = "actions.show_help";
			"<CR>" = "actions.select";
			"<C-s>" = "actions.select_vsplit";
			"<C-h>" = "actions.select_split";
			"<C-t>" = "actions.select_tab";
			"<C-p>" = "actions.preview";
			"<C-c>" = "actions.close";
			"<C-l>" = "actions.refresh";
			"-" = "actions.parent";
			"_" = "actions.open_cwd";
			"`" = "actions.cd";
			"~" = "actions.tcd";
			"gs" = "actions.change_sort";
			"gx" = "actions.open_external";
			"g." = "actions.toggle_hidden";
			"g\\" = "actions.toggle_trash";
		};
		defaultFileExplorer = true; # Replace netrw
		deleteToTrash = true;
		skipConfirmForSimpleEdits = true;
		bufOptions = {
			bufhidden = "hide";
			buflisted = false;
		};
		viewOptions = {
			showHidden = true;
			# Hide .git folders
			isAlwaysHidden = /*lua*/ ''
				function(name, bufnr)
					if name == ".git" then
						return true
					else
						return false
					end
				end
			'';
		};
		winOptions = {
			wrap = false;
			signcolumn = "no";
			cursorcolumn = false;
			foldcolumn = "0";
			spell = false;
			list = false;
			conceallevel = 3;
			concealcursor = "nvic";
		};
		columns = {
			icon.enable = true;
			# permissions.enable = true;
			# size.enable = true;
			# mtime.enable = true;
			# type.enable = true;
		};
	};

	# plugins.nvim-tree = {
	# 	enable = true;
	# 	hijackCursor = true;
	# 	syncRootWithCwd = true;
	# };

	keymaps = [
		# (mkKeymap "n" "<leader>et" ":NvimTreeToggle<cr>")
		# (mkKeymap "n" "<leader>ef" ":NvimTreeFocus<cr>")
		# (mkKeymap "n" "<leader>er" ":NvimTreeRefresh<cr>")

		(mkKeymap "n" "<leader>ee" ":Oil<cr>")
	];

	plugins.which-key.registrations = {
		"<leader>e" = "Explorer";
	};
}
