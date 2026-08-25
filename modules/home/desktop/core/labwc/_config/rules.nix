{lib, ...}: let
  mkAction = name: attrs:
    {"@name" = name;}
    // lib.mapAttrs' (attr: value: lib.nameValuePair "@${attr}" value) attrs;
  center = mkAction "AutoPlace" {policy = "center";};
in {
  wayland.windowManager.labwc.rc.windowRules.windowRule = [
    {
      "@identifier" = "steam";
      "@title" = "Friends List";
      action = mkAction "ResizeTo" {
        width = "360";
        height = "700";
      };
    }

    {
      "@title" = "notificationtoasts_*_desktop";
      "@ignoreFocusRequest" = "yes";
      action = mkAction "ToggleAlwaysOnTop" {};
    }

    {
      "@identifier" = "mpv";
      action = [
        (mkAction "ResizeTo" {
          width = "768";
          height = "432";
        })
        center
      ];
    }
    {
      "@title" = "Picture in picture";
      "@ignoreFocusRequest" = "yes";
      action = [
        (mkAction "ResizeTo" {
          width = "640";
          height = "360";
        })
        center
        (mkAction "ToggleAlwaysOnTop" {})
      ];
    }

    # {
    #   "@identifier" = "REAPER";
    #   "@title" = "Add FX*";
    #   action = [
    #     (mkAction "ResizeTo" {
    #       width = "672";
    #       height = "540";
    #     })
    #     center
    #   ];
    # }
    # {
    #   "@identifier" = "REAPER";
    #   "@title" = "Routing*";
    #   action = center;
    # }
    # {
    #   "@identifier" = "REAPER";
    #   "@title" = "REAPER v*";
    #   action = mkAction "Maximize" {};
    # }
    # {
    #   "@identifier" = "com.bitwig.BitwigStudio";
    #   action = mkAction "Maximize" {};
    # }
  ];
}
