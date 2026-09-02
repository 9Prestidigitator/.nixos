{
  lib,
  options,
  config,
  ...
}: {
  programs.noctalia.settings = lib.mkIf (options ? programs.umbriel.enable && config.programs.umbriel.enable) {
    shell = {
      popup_shadows = false;
      shadow.alpha = 0.0;
    };
  };
}
