{
  inputs,
  self,
  ...
}: {
  flake.homeModules.umbriel = {
    imports = [
      inputs.umbriel.homeModules.default
      inputs.niri-flake.homeModules.config
      self.homeModules.wlr-which-key
      (inputs.import-tree ./_config)
    ];

    programs.umbriel = {
      enable = true;
      settings = {
        layout.gap = 5;
        input.touchpad = {
          tap = true;
          natural_scroll = true;
        };
        keybinds = {
          "Mod+Return" = "spawn:kitty";

          "Mod+Left" = "window-focus-left";
          "Mod+Right" = "window-focus-right";
          "Mod+Up" = "window-focus-up";
          "Mod+Down" = "window-focus-down";

          "Mod+H" = "window-focus-left";
          "Mod+L" = "window-focus-right";
          "Mod+K" = "window-focus-up";
          "Mod+J" = "window-focus-down";

          "Mod+Q" = "window-close";
          "Mod+O" = "overview-toggle";
          "Mod+Ctrl+Space" = "window-toggle-floating";
          "Mod+F" = "window-toggle-maximize-to-edges";
          "Mod+Shift+F" = "window-toggle-fullscreen";
          "Mod+R" = "window-cycle-width";

          "Mod+Minus" = "window-modify-width:-0.1";
          "Mod+Equal" = "window-modify-width:0.1";

          "Mod+PageUp" = "workspace-previous";
          "Mod+U" = "workspace-previous";
          "Mod+PageDown" = "workspace-next";
          "Mod+D" = "workspace-next";
        };
        appearance.blur = {
          enabled = true;
          optimized = true;
          passes = 3;
          radius = 5;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.1;
        };
      };
    };
  };
}
