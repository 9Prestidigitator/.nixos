{
  flake.nixosModules.chromium = {
    programs.chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb"
        "hkgfoiooedgoejojocmhlaklaeopbecg"
        "gebbhagfogifgggkldgodflihgfeippi"
        "ioimlbgefgadofblnajllknopjboejda"
      ];
    };
  };
}
