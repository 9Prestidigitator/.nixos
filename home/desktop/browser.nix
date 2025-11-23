{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # Vimium
      {id = "hkgfoiooedgoejojocmhlaklaeopbecg";} # Picture in picture
      {id = "inomeogfingihgjfjlpeplalcfajhgai";} # Chrome Remote Desktop
      {id = "gebbhagfogifgggkldgodflihgfeippi";} # Youtube Dislike
    ];
    commandLineArgs = ["--disable-features=WaylandWpColorManagerV1"];
  };
}
