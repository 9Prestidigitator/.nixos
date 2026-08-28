{
  config,
  lib,
  ...
}: {
  wayland.windowManager.mango.settings = lib.mkIf (config.desktop.shell == "noctalia") {
    bind = [
      "SUPER,space,spawn,noctalia msg panel-toggle launcher"
      "NONE,XF86Favorites,spawn,noctalia msg panel-toggle control-center"
      "SUPER,Escape,spawn,noctalia msg session lock"
      "CTRL+ALT,Delete,spawn,noctalia msg panel-toggle session"
      "NONE,Print,spawn,noctalia msg screenshot-region"
      "SHIFT,Print,spawn,noctalia msg screenshot-fullscreen"
    ];
    bindr = ["SUPER,Super_L,spawn,noctalia msg panel-toggle control-center"];
  };
}
