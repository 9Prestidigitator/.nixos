{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    extensions = [
      {
        id = "inomeogfingihgjfjlpeplalcfajhgai";
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
      }
      {
        id = "hkgfoiooedgoejojocmhlaklaeopbecg";
      }
      {
        id = "gebbhagfogifgggkldgodflihgfeippi";
      }
    ];
    commandLineArgs = ["WaylandWpColorManagerV1=false"];
  };

  home.packages = with pkgs; [
    brave
  ];
}
