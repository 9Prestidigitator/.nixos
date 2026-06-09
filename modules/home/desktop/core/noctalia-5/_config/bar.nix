{
  programs.noctalia.settings.bar = {
    order = ["default"];
    default = {
      auto_hide = true;
      layer = "overlay";
      scale = 1;

      start = ["workspaces" "active_window"];
      center = ["control-center"];
      end = [
        "tray"
        "clipboard"
        "notifications"
        "bluetooth"
        "volume"
        "network"
        "battery"
        "clock"
        "date"
      ];

      margin_edge = 0;
      margin_ends = 0;

      radius = 0;
      widget_spacing = 8;
      reserve_space = false;
    };
  };
}
