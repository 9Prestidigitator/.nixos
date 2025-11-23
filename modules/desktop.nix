{
  pkgs,
  inputs,
  ...
}: {
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
  ];
}
