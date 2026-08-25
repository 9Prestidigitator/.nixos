{
  flake.homeModules.labwc = {
    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
      rc = {
        theme = {
          name = "nord";
          cornerRadius = 8;
          font = {
            "@name" = "FiraCode";
            "@size" = "11";
          };
        };
        keyboard = {
          default = true;
          keybind = [
            {
              "@key" = "W-Return";
              action = {
                "@name" = "Execute";
                "@command" = "kitty";
              };
            }
            {
              "@key" = "W-Esc";
              action = {
                "@name" = "Execute";
                "@command" = "noctalia msg session lock";
              };
            }
          ];
        };
      };
    };
  };
}
