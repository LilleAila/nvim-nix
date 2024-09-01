{
  pkgs,
  inputs,
  mkKeymap,
  ...
}:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "obsidian-bridge.nvim";
      src = inputs.plugin-obsidian-bridge;
    })
  ];

  extraConfigLua = # lua
    ''
      -- Token is defined in the environment variable $OBSIDIAN_REST_API_KEY
      require("obsidian-bridge").setup({
        scroll_sync = true;
      })
    '';

  keymaps = [
    (mkKeymap "n" "<leader>og" ":ObsidianBridgeOpenGraph<cr>" "Open graph")
  ];
}
