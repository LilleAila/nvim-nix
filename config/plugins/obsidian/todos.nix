{
  inputs,
  pkgs,
  mkKeymap,
  ...
}:
{
  extraPlugins = [ inputs.plugin-obsidian-todo.packages.${pkgs.system}.default ];

  plugins.telescope.settings.extensions.obsidian_todo = {
    search_path = "/home/olai/notes/obsidian";
  };

  extraConfigLua = # lua
    ''
      require("telescope").load_extension("obsidian_todo")
    '';

  keymaps = [
    (mkKeymap "n" "<leader>ot" ":Telescope obsidian_todo obsidian_todo<cr>" "Tags")
  ];
}
