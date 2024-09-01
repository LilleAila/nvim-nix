{ pkgs, inputs, ... }:
{
  plugins.image = {
    enable = false; # images render incorrectly (too high up sometimes), config doesn't get applied
    backend = "kitty";
    windowOverlapClearEnabled = true;
    windowOverlapClearFtIgnore = [ ];
    integrations.markdown = {
      enabled = true;
      # onlyRenderImageAtCursor = true;
      downloadRemoteImages = true;
      clearInInsertMode = true;
    };
    extraOptions.integrations.markdown.resolve_image_path = {
      __raw = # lua
        ''
          function(_, image_path, fallback)
            -- The document_path provided to the function doesn't work with obsidian for some reason
            -- local document_path = vim.fn.expand("%:p")
            local document_path = vim.api.nvim_buf_get_name(0)
              -- change this to whatever is your obsidian vault path
            if string.find(document_path, "Obsidian Vault") then
              -- maybe it'd be better to somehow use an absolute path, but it doesn't look like there's an easy way to do it `:h fnamemodify()` does not support that.
              -- this too
              return "~/Documents/Obsidian Vault/" .. image_path
            else
              return fallback(document_path, image_path)
            end
          end
        '';
    };
  };

  /*
    # doesn't work at all
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "hologram.nvim";
        src = inputs.plugin-hologram;
      })
    ];

    extraConfigLua = ''
      require("hologram").setup({
        auto_display = true
      })
    '';
  */
}
