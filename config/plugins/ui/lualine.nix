{...}: {
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    iconsEnabled = true;
    # sectionSeparators = { left = ""; right = ""; };
    sectionSeparators = {
      left = "";
      right = "";
    };
    componentSeparators = {
      left = "";
      right = "";
    };
    sections = {
      lualine_a = ["mode"];
      lualine_b = ["branch" "diff" "diagnostics"];
      lualine_c = ["filename"];
      lualine_x = ["encoding" "fileformat" "filetype"];
      lualine_y = ["progress"];
      lualine_z = ["location"];
    };
  };
}
