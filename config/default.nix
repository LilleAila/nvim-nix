{
  imports = [
		./options.nix
		./plugins
  ];

	plugins.lsp = {
		enable = true;
		servers = {
			tsserver.enable = true;
			lua-ls.enable = true;
		};
	};
}
