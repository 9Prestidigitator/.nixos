{
  flake.homeModules.bluetooth = {
    services.blueman-applet.enable = false;
    dconf.settings."org/blueman/general" = {
      plugin-list = ["!ShowConnected" "!StatusIcon"];
    };
  };
}
