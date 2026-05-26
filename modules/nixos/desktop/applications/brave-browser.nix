{
  flake.nixosModules.brave-browser = {pkgs, ...}: {
    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
        "ioimlbgefgadofblnajllknopjboejda"
      ];
    };

    environment.systemPackages = with pkgs; [brave];

    persist.userDirs = [
      ".cache/BraveSoftware"
      ".config/BraveSoftware"
    ];
  };
}
