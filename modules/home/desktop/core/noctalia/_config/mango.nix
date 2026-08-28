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
  };
}
