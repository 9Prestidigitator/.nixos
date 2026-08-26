{pkgs, ...}: {
  host.name = "cardboard";

  home-manager.users = {
    max = {self, ...}: {
      imports = with self.homeModules; [
        self.userModules.max.homeModule

        plasma

        bash
        neovim
        fastfetch

        kitty
        nautilus
        mpv
        spotify
        bluetooth

        stylix
      ];
    };

    guest = {self, ...}: {
      imports = with self.homeModules; [
        self.userModules.guest.homeModule

        plasma

        bash
        neovim
        fastfetch

        nautilus
        mpv
        spotify
        discord
        bluetooth

        stylix
      ];
    };
  };

  users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7+7QTIxfPUGf8bYnZ8U/M7deNYriv6upTRsUtafdAA"];

  systemd.sleep.settings.Sleep.AllowSuspend = "no";
  powerManagement.cpuFreqGovernor = "performance";

  services.uxplay.dynamicFirewall = false;
  environment.systemPackages = [pkgs.kdePackages.plasma-bigscreen];

  system.stateVersion = "25.11";
  home-manager.sharedModules = [{home.stateVersion = "25.11";}];
}
