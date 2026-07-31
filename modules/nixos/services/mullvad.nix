{
  flake.nixosModules.mullvad = {
    services.mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };
    # networking.firewall.checkReversePath = "loose";

    persist.directories = ["/etc/mullvad-vpn"];
  };
}
