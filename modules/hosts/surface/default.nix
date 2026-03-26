{
  inputs,
  self,
  ...
}: {
  imports = [inputs.nixos-hardware.nixosModules.microsoft-surface-common];
  flake = {
    nixosConfiguration.surface = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {isLaptop = true;};
      modules = with self.nixosModules; [
        max

        niri

        essentials
        braveBrowser
        musicProduction
        design
        gaming
        media
        comms
        vm

        terminalTools
        mullvad

        buildMachines
        stylix

        tablet
        keyd
        grub
        nvidia
        systemGeneral

        surface
      ];
    };

    nixosModules.surface = {pkgs, lib, ...}: {
      networking = {
        hostName = "surface";
        networkmanager.enable = true;
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
        thermald.enable = true;
      };

      nix = {
        buildMachines = [
          {
            hostName = "builder";
            system = "x86_64-linux";
            protocol = "ssh-ng";
            maxJobs = 4;
            speedFactor = 2;
            supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
          }
        ];
        distributedBuilds = true;
      };

      powerManagement.cpuFreqGovernor = "performance";

      hardware.bluetooth.enable = false;
      services.blueman.enable = false;

      # Enable touchpad support (enabled default in most desktopManager).
      services.libinput.enable = true;
      security.rtkit.enable = true;

      console.font = lib.mkForce "ter-v32b";
    };
  };
}
