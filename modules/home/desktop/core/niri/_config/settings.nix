{
  config,
  osConfig,
  ...
}: {
  programs.niri = {
    package = osConfig.programs.niri.package;
    settings = with config.lib.stylix.colors; {
      input = {
        keyboard = {
          xkb = {};
          numlock = true;
        };
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };
        mouse = {
          accel-profile = "flat";
        };
        warp-mouse-to-focus.enable = false;
      };

      overview = {
        workspace-shadow.enable = true;
        backdrop-color = null;
        zoom = 0.4;
      };

      blur = {
        enable = true;
        passes = 3;
        offset = 3.0;
        noise = 0.03;
        saturation = 1.0;
      };

      cursor.hide-when-typing = true;

      layout = {
        background-color = "transparent";

        focus-ring = {
          enable = true;
          width = 2.7;
          active.gradient = {
            angle = 45;
            from = "#${base0B}";
            to = "#${base0D}";
            relative-to = "workspace-view";
          };
          urgent.color = "#${base08}";
          inactive.color = "transparent";
        };

        border.enable = false;

        preset-column-widths = [
          {proportion = 0.3333;}
          {proportion = 0.5;}
          {proportion = 0.6666;}
        ];
        struts = {
          top = 3;
          bottom = 3;
          right = 3;
          left = 3;
        };

        default-column-width = {proportion = 0.5;};
        gaps = 7;
        center-focused-column = "never";
      };

      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;
      screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      debug."honor-xdg-activation-with-invalid-serial" = [];
    };
  };
}
