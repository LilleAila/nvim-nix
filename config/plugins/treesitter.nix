{
	plugins.treesitter = {
		enable = true;
		indent = true;
		grammarPackages = with plugins.treesitter.package.builtGrammars; [
			bash
			c
			cmake
			comment
			cpp
			css
			csv
			diff
			dockerfile
			fish
			gitcommit
			gitignore
			git_rebase
			graphql
			html
			ini
			javascript
			json
			jsonc
			lua
			make
			markdown
			markdown_inline
			meson
			ninja
			nix
			prisma
			po
			python
			rasi
			requirements # pip requirements.txt
			rst
			rust
			sql
			toml
			tsv
			tsx
			typescript
			vim
			vimdoc
			xml
			yaml
		];
	};
}
