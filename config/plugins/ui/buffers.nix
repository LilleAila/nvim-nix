{ mkRegistration, ... }:
{
  plugins.barbar = {
    enable = true;
    settings = {
      animation = false;
      auto_hide = false;
      clickable = true;
      focus_on_close = "left";
      insert_at_end = false;
      insert_at_start = false;
      maximum_length = 30;
      maximum_padding = 2;
      minimum_padding = 1;
      no_name_title = "[No Name]";
    };
    keymaps = {
      close.key = "<C-c>";
      goTo1.key = "<C-1>";
      goTo2.key = "<C-2>";
      goTo3.key = "<C-3>";
      goTo4.key = "<C-4>";
      goTo5.key = "<C-5>";
      goTo6.key = "<C-6>";
      goTo7.key = "<C-7>";
      goTo8.key = "<C-8>";
      goTo9.key = "<C-9>";
      last.key = "<C-0>";
      previous.key = "<S-Tab>";
      next.key = "<Tab>";
      movePrevious.key = "<C-,>";
      moveNext.key = "<C-.>";

      pick.key = "<leader>bo";
      pin.key = "<leader>bp";
    };
  };

  plugins.which-key.settings.spec = [
    (mkRegistration "<leader>bo" "Open")
    (mkRegistration "<leader>bp" "Pin")
  ];
}
