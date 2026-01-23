{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking.hostName = "ink";
  networking.networkmanager.enable = true;

  desktop = {
    enable = true;
    wayCompositor = "niri";
    x11WM = "i3";
    musicprod.enable = true;
    gaming.enable = true;
    design.enable = true;
    comms.enable = true;
    media.enable = true;
    vm.enable = true;
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "threadirqs"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
      "acpi_enforce_resources=lax"
    ];
  };

  fileSystems."/mnt/win" = {
    device = "/dev/disk/by-uuid/01DC699B1D247C50";
    fsType = "ntfs-3g";
    options = ["nofail" "uid=1000" "gid=100" "umask=022"];
  };

  fileSystems."/mnt/1tb_ssd" = {
    device = "/dev/disk/by-uuid/78174bbc-f96b-4325-87b2-db3cebdf345c";
    fsType = "ext4";
    options = ["nofail" "defaults"];
  };

  fileSystems."/mnt/1tb_hdd" = {
    device = "/dev/disk/by-uuid/7E90B7D790B7945D";
    fsType = "ntfs-3g";
    options = ["nofail" "uid=1000" "gid=100" "umask=022"];
  };

  services.udev.extraRules = ''
    KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
  '';

  services.xserver.videoDrivers = ["nvidia"];

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  powerManagement.cpuFreqGovernor = "performance";

  services.blueman.enable = true;
  services.libinput.enable = true;
  services.acpid.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.logind = {
    settings.Login = {
      HandlePowerKey = "suspend";
    };
  };

  # nix.settings.trusted-public-keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvu92jVCd5MoCslOCu3IoVtSxdKXvVhBuhcbIoZ6mW3"
  # ];

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
