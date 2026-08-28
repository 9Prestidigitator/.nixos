{
  lib,
  options,
  config,
  ...
}: {
  programs.noctalia.settings = lib.mkIf (options ? wayland.windowManager.mango.enable && config.wayland.windowManager.mango.enable) {
    shell = {
      popup_shadows = false;
      shadow.alpha = 0.0;
    };
    plugins = {
      enaled = [
        "ezequiel/mango_layouts"
        "gambled23/mangowm-keymode"
      ];
    };
  };
}
