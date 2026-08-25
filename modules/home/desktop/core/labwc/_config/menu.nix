{
  wayland.windowManager.labwc.menu = [
    {
      menuId = "client-menu";
      label = "Window";
      items = [
        {
          label = "Maximize";
          action.name = "ToggleMaximize";
        }
        {
          label = "Fullscreen";
          action.name = "ToggleFullscreen";
        }
        {
          label = "Restore floating";
          action.name = "UnSnap";
        }
        {
          label = "Decorations";
          action.name = "ToggleDecorations";
        }
        {
          label = "Always on top";
          action.name = "ToggleAlwaysOnTop";
        }
        {
          label = "Sticky on all workspaces";
          action.name = "ToggleOmnipresent";
        }
        {separator = {};}
        {
          label = "Move to previous workspace";
          action = {
            name = "SendToDesktop";
            to = "left";
          };
        }
        {
          label = "Move to next workspace";
          action = {
            name = "SendToDesktop";
            to = "right";
          };
        }
        {separator = {};}
        {
          label = "Close";
          action.name = "Close";
        }
      ];
    }
    {
      menuId = "root-menu";
      label = "Applications";
      items = [
        {
          label = "Terminal";
          action = {
            name = "Execute";
            command = "kitty";
          };
        }
        {
          label = "Browser";
          action = {
            name = "Execute";
            command = "brave";
          };
        }
        {
          label = "Files";
          action = {
            name = "Execute";
            command = "nautilus -w";
          };
        }
        {separator = {};}
        {
          label = "Reconfigure";
          action.name = "Reconfigure";
        }
        {
          label = "Exit";
          action.name = "Exit";
        }
      ];
    }
  ];
}
