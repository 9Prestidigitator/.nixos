{
  flake.homeModules.bluetooth = {
    # redundant but works
    services.blueman-applet.enable = false;
    dconf.settings."org/blueman/general" = {
      plugin-list = ["!ShowConnected" "!StatusIcon"];
    };
  };
}
