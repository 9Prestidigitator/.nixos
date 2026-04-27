{
  flake.nixosModules.mullvad = {pkgs, ...}: {
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    environment.systemPackages = with pkgs; [mullvad];
    services.resolved.enable = true;
    networking.firewall.checkReversePath = "loose";
  };
}
