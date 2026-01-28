{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  fetchurl = pkgs.fetchurl;
  commit = "69d1e5826e6380c8ff0cd532e244482097562c3d";
in {
  imports = [
    ../../modules
    ./hardware-configuration.nix
    ./minecraft-server.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-common
  ];

  networking.hostName = "surface";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  desktop = {
    enable = true;
    wayCompositor = "gnome";
  };

  hardware.microsoft-surface.kernelVersion = "longterm";

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
      };
    };

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
          #
          # Other
          #
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

  environment.etc = {
    "ipts.conf".text = ''
      [Config]
      BlockOnPalm = true
    '';
    "thermald/thermal-cpu-cdev-order.xml".source = fetchurl {
      url = "https://raw.githubusercontent.com/linux-surface/linux-surface/${commit}/contrib/thermald/surface_pro_5/thermal-conf.xml.auto.mobile";
      sha256 = "1wsrgad6k4haw4m0jjcjxhmj4742kcb3q8rmfpclbw0czm8384al";
    };
  };

  environment.systemPackages = with pkgs; [iptsd surface-control];

  services = {
    udev.packages = with pkgs; [iptsd surface-control];
    thermald.enable = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  security.rtkit.enable = true;

  console.font = lib.mkForce "ter-v32b";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
