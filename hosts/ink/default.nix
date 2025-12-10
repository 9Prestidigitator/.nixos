{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "threadirqs"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "nvidia_drm.modeset=1"
    ];
  };

  home-manager.users.${username} = {
    programs.bash = {
      shellAliases = {
        nixre = "sudo nixos-rebuild switch --upgrade --impure --flake .#ink";
      };
    };
  };

  fileSystems."/mnt/win" = {
    device = "/dev/disk/by-uuid/01DC699B1D247C50";
    fsType = "ntfs-3g";
    options = ["nofail" "uid=1000" "gid=100" "umask=022"];
  };

  fileSystems."/mnt/1tb_ssd" = {
    device = "/dev/disk/by-uuid/da22c9ae-04ab-4c7f-a248-e90940025e29";
    fsType = "ext4";
    options = ["defaults"];
  };

  fileSystems."/mnt/1tb_hdd" = {
    device = "/dev/disk/by-uuid/7E90B7D790B7945D";
    fsType = "ntfs-3g";
    options = ["nofail" "uid=1000" "gid=100" "umask=022"];
  };

  services.udev.extraRules = ''
    KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
    SUBSYSTEM=="usb", ATTR{idVendor}=="1935", MODE="0666"
  '';

  networking = {
    hostName = "ink";
    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  security.rtkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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
