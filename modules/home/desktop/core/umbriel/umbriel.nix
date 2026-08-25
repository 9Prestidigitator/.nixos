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
        input = {
          middle_click_paste = false;
          touchpad = {
            tap = true;
            natural_scroll = true;
          };
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
