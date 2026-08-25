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
        input.keyboard.layout = "de";
        keybinds = {
          "Mod+Return" = "spawn:kitty";
          "Mod+Q" = "window-close";
        };
      };
    };
  };
}
