{
  inputs,
  self,
  ...
}: {
  flake.homeModules.umbriel = let
    noctalia = cmd: "spawn:noctalia msg ${cmd}";
  in
    {
      lib,
      config,
      ...
    }: {
      imports = [
        inputs.umbriel.homeModules.default
        inputs.niri-flake.homeModules.config
        self.homeModules.wlr-which-key
      ];

      programs.umbriel = {
        settings = {
          layout.gap = 5;
          input.keyboard.layout = "de";
          keybinds = {
            "Mod+Return" = "spawn:kitty";
            "Mod+Q" = "window-close";
          };
        };
      };

      config = lib.mkIf (config.desktop.shell == "noctalia") {
        programs.umbriel.settings = {
          keybinds = {
            "Mod" = noctalia "panel-toggle launcher";
          };
        };
      };
    };
}
