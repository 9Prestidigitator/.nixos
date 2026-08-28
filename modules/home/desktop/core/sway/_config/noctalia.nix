{
  config,
  lib,
  options,
  ...
}: let
  modifier = "Mod4";
in {
  config = lib.mkIf (options ? programs.noctalia.enable && config.programs.noctalia.enable) {
    wayland.windowManager.sway.config = rec {
      menu = "noctalia msg panel-toggle launcher";
      keybindings = lib.mkOptionDefault {
        "XF86Favorites" = "exec noctalia msg panel-toggle control-center";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+Escape" = "exec noctalia msg session lock";
        "Control+Alt+Delete" = "exec noctalia msg panel-toggle session";
        "Print" = "exec noctalia msg screenshot-region";
        "Shift+Print" = "exec noctalia msg screenshot-fullscreen";
      };
    };
  };
}
