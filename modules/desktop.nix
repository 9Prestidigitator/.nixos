{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options = {
    desktop.enable = lib.mkEnableOption "Enables standard desktop configration (niri + noctalia).";
  };

  config = lib.mkIf config.desktop.enable {
    programs.niri.enable = true;

    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
      ];
      extraOpts = {"WaylandWpColorManagerV1" = false;};
    };

    environment.systemPackages = with pkgs; [
      brave
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.qt6.qtdeclarative
    ];
  };
}
