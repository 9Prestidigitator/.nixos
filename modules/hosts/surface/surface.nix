{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.surface = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        max

        gdm
        gnome

        essentials
        brave-browser

        terminal-tools
        minecraft-server

        build-machines
        stylix

        keyd
        sops
        grub
        intel
        system-general
        home-manager
        nix

        surface

        inputs.nixos-hardware.nixosModules.microsoft-surface-common
      ];
    };

    nixosModules.surface = {
      pkgs,
      lib,
      ...
    }: {
      networking = {
        hostName = "surface";
        networkmanager.enable = true;
      };

      home-manager = {
        extraSpecialArgs = {
          inherit inputs;
          isLaptop = true;
        };
        users.max = {
          imports = with self.homeModules; [
            max

            gnome

            neovim
            terminal-tools

            stylix
          ];
          home = {
            username = "max";
            homeDirectory = "/home/max";
            stateVersion = "26.05";
          };
        };
      };
      hardware.microsoft-surface.kernelVersion = "longterm";

      boot = {
        kernelParams = ["mem_sleep_default=deep" "kernel.nmi_watchdog=0" "vm.dirty_writeback_centisecs=1500"];
        extraModprobeConfig = ''
          options i915 enable_fbc=1 enable_rc6=1 modeset=1
          options snd_hda_intel power_save=1
          options snd_ac97_codec power_save=1
          options iwldvm force_cam=N
          options iwlwifi power_save=N
          options iwlmvm power_schema=1
        '';
        initrd = {
          availableKernelModules = ["xhci_pci" "nvme" "usbhid"];
          kernelModules = ["surface_aggregator" "surface_aggregator_registry" "surface_aggregator_hub"];
        };

        kernelPatches = [
          {
            name = "surface-config";
            patch = null;
            # Options from https://github.com/linux-surface/linux-surface/blob/master/configs/surface-5.13.config
            extraConfig = ''
              # Other
              # Prevent a non-fatal "kernel oops" at boot crashing udev
              # (https://github.com/linux-surface/linux-surface/issues/61#issuecomment-579298172)
              PINCTRL_INTEL y
              PINCTRL_SUNRISEPOINT y
              # Required for reading battery data
              # (https://github.com/linux-surface/surface-aggregator-module/wiki/Testing-and-Installing)
              SERIAL_DEV_BUS y
              SERIAL_DEV_CTRL_TTYPORT y
              MFD_INTEL_LPSS_PCI y
              INTEL_IDMA64 y
            '';
          }
        ];
      };

      environment.systemPackages = with pkgs; [iptsd surface-control];

      services = {
        udev.packages = with pkgs; [iptsd surface-control];
        blueman.enable = true;
      };

      hardware.sensor.iio.enable = true;

      powerManagement.cpuFreqGovernor = "performance";

      console.font = lib.mkForce "ter-v32b";

      users.users.max.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII00su22rL1ZJ59mb8+HVw21zft7IMLrd6yVvKd6f9Y2"];
    };
  };
}
