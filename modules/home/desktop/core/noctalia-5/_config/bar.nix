{
  programs.noctalia.settings = {
    bar = {
      order = ["default"];
      default = {
        auto_hide = true;
        layer = "overlay";
        scale = 1;
        background_opacity = 1;
        thickness = 34;
        padding = 14;

        start = ["taskbar"];
        center = ["control-center"];
        end = [
          "tray"
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

    widget = {
      taskbar = {
        group_by_workspace = true;
        hide_empty_workspaces = true;
        inactive_opacity = 0.9;
        workspace_label_placement = "centered";
      };
      tray = {
        drawer = true;
      };
    };
  };
}
