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

  networking.hostName = "book";
  networking.networkmanager.enable = true;

  desktop = {
    enable = true;
    wayCompositor = "niri";
    x11WM = "none";
    # comms.enable = true;
    # media.enable = true;
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

  boot.kernelPatches = [
    {
      name = "chrultrabook-stoney-audio";
      patch = inputs.stoney-kernel + "/patches/audio.patch";
    }
  ];

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

  services.udev.extraRules = ''
    KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
  '';

  services.thermald.enable = true;
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.acpid.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).

  services.logind = {
    settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "suspend";
    };
  };

  fileSystems."/mnt/SD" = {
    device = "/dev/disk/by-label/SD";
    fsType = "exfat";
    options = [
      "nofail"
      "x-systemd.automount"
      "uid=1000"
      "gid=100"
      "umask=0022"
    ];
  };

  # networking.wg-quick.interfaces.wg0 = {
  #   configFile = "/secret/wg0.conf";
  #   autostart = false;
  # };

  services.keyd = {
    keyboards.default = {
      settings = {
        main = {
          mouse2 = "leftmeta";
          mouse1 = "esc";
          capslock = "overload(mod5, esc)";
        };
        mod5 = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          u = "pageup";
          d = "pagedown";
          backspace = "delete";
        };
        "shift:S" = {
          capslock = "capslock";
        };
        "mod5+shift" = {
          g = "end";
        };

        main = {
          f1 = "back";
          f2 = "forward";
          f3 = "refresh";
          f4 = "print";
          f5 = "A-tab";
          f6 = "brightnessdown";
          f7 = "brightnessup";
          f8 = "mute";
          f9 = "volumedown";
          f10 = "volumeup";
        };

        # Allow F1-10 access through meta+fnX
        meta = {
          f1 = "f1";
          f2 = "f2";
          f3 = "f3";
          f4 = "f4";
          f5 = "f5";
          f6 = "f6";
          f7 = "f7";
          f8 = "f8";
          f9 = "f9";
          f10 = "f10";
        };

        # Allow TTY access
        "control+alt" = {
          f1 = "C-A-f1";
          f2 = "C-A-f2";
          f3 = "C-A-f3";
          f4 = "C-A-f4";
          f5 = "C-A-f5";
          f6 = "C-A-f6";
          f7 = "C-A-f7";
          f8 = "C-A-f8";
          f9 = "C-A-f9";
          f10 = "C-A-f10";
          left = "home";
          right = "end";
        };

        "control+alt" = {
          up = "home";
          down = "end";
        };

        "alt" = {
          backspace = "delete";
          up = "pageup";
          down = "pagedown";
        };
      };
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
