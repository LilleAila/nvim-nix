{...}: {
  plugins.fidget = {
    enable = true;
    logger = {
      level = "warn";
      floatPrecision = 0.1;
      path = "string.format('%s/fidget.nvim.log', vim.fn.stdpath('cache'))";
    };

    progress = {
      pollRate = 0;
      suppressOnInsert = true;
      ignoreDoneAlready = false;
      ignoreEmptyMessage = false;
      clearOnDetach = ''
        function(client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end
      '';
      notificationGroup = ''
        function(msg) return msg.lsp_client.name end
      '';
      ignore = [];
      lsp.progressRingbufSize = 0;
      display = {
        renderLimit = 16;
        doneTtl = 3;
        doneIcon = "✔";
        doneStyle = "Constant";
        progressTtl = "math.huge";
        progressIcon = {
          pattern = "dots";
          period = 1;
        };
        progressStyle = "WarningMsg";
        groupStyle = "Title";
        iconStyle = "Question";
        priority = 30;
        skipHistory = true;
        formatMessage = ''
          require ("fidget.progress.display").default_format_message
        '';
        formatAnnote = ''
          function (msg) return msg.title end
        '';
        formatGroupName = ''
          function (group) return tostring (group) end
        '';
        overrides = {
          rust_analyzer = {
            name = "rust-analyzer";
          };
        };
      };
    };

    notification = {
      pollRate = 10;
      filter = "info";
      historySize = 128;
      overrideVimNotify = true;
      redirect = ''
        function(msg, level, opts)
          if opts and opts.on_open then
            return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
          end
        end
      '';
      configs = {
        default = "require('fidget.notification').default_config";
      };

      window = {
        normalHl = "Comment";
        winblend = 0;
        border = "none";
        zindex = 45;
        maxWidth = 0;
        maxHeight = 0;
        xPadding = 1;
        yPadding = 0;
        align = "bottom";
        relative = "editor";
      };
      view = {
        stackUpwards = true;
        iconSeparator = " ";
        groupSeparator = "---";
        groupSeparatorHl = "Comment";
      };
    };
  };
}
