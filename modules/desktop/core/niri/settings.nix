{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.niri = {
    package = pkgs.niri;
    settings = with config.lib.stylix.colors; {
      spawn-at-startup = [
        {argv = ["sunshine"];}
      ];
      input = {
        keyboard = {
          xkb = {
            # You can set rules, model, layout, variant and options.
            # For more information, see xkeyboard-config(7).

            # For example:
            # layout = "us,ru";
            # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
          };
          numlock = true;
        };
        # Next sections include libinput settings.
        # Omitting settings disables them, or leaves them at their default values.
        # All commented-out settings here are examples, not defaults.
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };
        mouse = {
          accel-profile = "flat";
        };
        # Uncomment this to make the mouse warp to the center of newly focused windows.
        warp-mouse-to-focus.enable = false;
      };
      overview = {
        workspace-shadow.enable = false;
        backdrop-color = "#${base00}";
      };
      layout = {
        focus-ring = {
          enable = true;
          width = 3;
          active.gradient = {
            angle = 45;
            from = "#${base0B}";
            to = "#${base0D}";
            relative-to = "workspace-view";
          };
          urgent.color = "#${base08}";
          inactive.color = "transparent";
        };
        border = {
          enable = false;
        };
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
      screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    };
  };
}
