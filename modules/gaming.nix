{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    gaming.enable = lib.mkEnableOption "Enable gaming configuration.";
  };

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      prismlauncher
      (bottles.override {removeWarningPopup = true;})
      heroic
    ];
  };
}
