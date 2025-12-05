{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/core.nix
    ../../home/development
    ../../home/desktop
  ];

  programs.git = {
    settings.user = {
      name = "9Prestidigitator";
      email = "9Prestidigitator@gmail.com";
    };
  };

  programs.kitty = {
    enable = true;
    # font = {
    #   name = "Hack Nerd Font";
    #   size = 10;
    # };
    settings = {
      # background_opacity = "0.9";
      dynamic_background_opacity = true;
      cursor_shape = "block";
      hide_window_decorations = "yes";
      wayland_enable_ime = "yes";
    };
  };
}
