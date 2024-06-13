{...}: {
  plugins.obsidian = {
    enable = true;
    settings = {
      picker.name = "telescope.nvim";
      templates.subdir = "Templates";
      attachments.img_folder = "Assets";
      workspaces = [
        {
          name = "personal";
          path = "~/Documents/Obsidian\ Vault";
        }
      ];
    };
  };
}
