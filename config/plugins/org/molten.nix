{pkgs, ...}: {
  plugins.molten = {
    enable = true;
  };

  # === DEPENDENCIES ===
  extraPython3Packages = p:
    with p; [
      pynvim
      jupyter-client
      cairosvg
      pnglatex
      plotly
      pyperclip
    ];

  extraLuaPackages = ps:
    with ps; [
      magick
    ];

  extraPackages = with pkgs; [
    imagemagick
  ];

  extraPlugins = with pkgs.vimPlugins; [
    image-nvim
  ];

  extraConfigLua =
    /*
    lua
    */
    ''
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      })
    '';
}
