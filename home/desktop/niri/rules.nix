{
  config,
  inputs,
  ...
}: {
  programs.niri.settings = {
    prefer-no-csd = true;
    window-rules = [
      {
        geometry-corner-radius = let
          radius = 5.0;
        in {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
        draw-border-with-background = false;
        clip-to-geometry = true;
      }
      {
        matches = [{is-floating = true;}];
        shadow.enable = true;
      }
      {
        matches = [
          {app-id = "brave-browser";}
        ];
        open-maximized = true;
      }
      {
        matches = [
          {title = "Confirm";}
          {title = "Authentication Required";}
          {title = "xdg-desktop-portal-gtk";}
        ];
        open-floating = true;
      }
      {
        matches = [{title = "Picture in picture";}];
        open-floating = true;
        default-floating-position = {
          x = 32;
          y = 32;
          relative-to = "bottom-right";
        };
        default-column-width = {fixed = 480;};
        default-window-height = {fixed = 270;};
      }
    ];
  };
}
