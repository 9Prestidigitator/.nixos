{
  flake.homeModules.kitty = {lib, ...}: {
    programs = {
      kitty = {
        enable = true;
        themeFile = "SpaceGray_Eighties";
        settings = {
          cursor_shape = "block";
          dynamic_background_opacity = lib.mkDefault true;
          wayland_enable_ime = lib.mkDefault "yes";
          hide_window_decorations = lib.mkDefault "yes";
          enable_audio_bell = false;
        };
      };
    };
  };
}
