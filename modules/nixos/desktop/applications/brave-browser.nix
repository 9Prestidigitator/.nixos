{
  flake.nixosModules.brave-browser = { pkgs, ... }: {
    programs.chromium = {
      enable = true;
      extensions = [
        "inomeogfingihgjfjlpeplalcfajhgai"
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
        "ioimlbgefgadofblnajllknopjboejda"
      ];
      extraOpts = {
        "WaylandWpColorManagerV1" = false;
      };
    };

    environment.systemPackages = with pkgs; [brave];
  };
}
