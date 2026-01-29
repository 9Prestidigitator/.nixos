{
  pkgs,
  ...
}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking.hostName = "cardboard";
  networking.networkmanager.enable = true;

  desktop = {
    enable = true;
    wayCompositor = "niri";
    x11WM = "i3";
    musicprod.enable = false;
    gaming.enable = false;
    design.enable = false;
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
