{
  plugins.barbar = {
    enable = true;
    animation = false;
    autoHide = false;
    clickable = true;
    focusOnClose = "left";
    insertAtEnd = false;
    insertAtStart = false;
    maximumLength = 30;
    maximumPadding = 2;
    minimumPadding = 1;
    noNameTitle = "[No Name]";
    keymaps = {
      silent = true;

      close = "<C-c>";
      goTo1 = "<C-1>";
      goTo2 = "<C-2>";
      goTo3 = "<C-3>";
      goTo4 = "<C-4>";
      goTo5 = "<C-5>";
      goTo6 = "<C-6>";
      goTo7 = "<C-7>";
      goTo8 = "<C-8>";
      goTo9 = "<C-9>";
      last = "<C-0>";
      previous = "<S-Tab>";
      next = "<Tab>";
      movePrevious = "<C-,>";
      moveNext = "<C-.>";

      pick = "<leader>bo";
      pin = "<leader>bp";
    };
  };

  plugins.which-key.registrations = {
    "<leader>bo" = "Open";
    "<leader>bp" = "Pin";
  };
}
