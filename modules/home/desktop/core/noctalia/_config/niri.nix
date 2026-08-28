{
  lib,
  osConfig,
  ...
}: {
  programs.noctalia.settings = lib.mkIf (osConfig.programs.niri.enable) {
    shell = {
      niri_overview_type_to_launch_enabled = false;
    };
  };
}
