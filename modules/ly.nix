{inputs, ...}: {
  flake.nixosModules.ly = {pkgs, ...}: {
    displayManager.ly = {
      enable = true;
      settings = {
        allow_empty_password = true;
        animation = "colormix";
        bigclock = "en";
        clock = "%c";
        lang = "en";
        numlock = true;
        vi_default_mode = "insert";
        vi_mode = true;
      };
    };
  };
}
