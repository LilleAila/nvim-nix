{...}: {
  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        # char = "▍";
        smart_indent_cap = true;
      };
      scope = {
        enabled = true;
        show_start = false;
        show_end = false;
      };
    };
  };
}
