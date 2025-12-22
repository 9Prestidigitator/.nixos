{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking.hostName = "surface";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlmvm power_schema=1
  '';

  desktop = {
    enable = true;
    musicprod.enable = false;
    gaming.enable = false;
    design.enable = false;
    comms.enable = false;
    media.enable = false;
    vm.enable = false;
  };

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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "threadirqs"
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  security.rtkit.enable = true;

  home-manager.sharedModules = [
    {
      programs.niri.settings = {
        # niri msg outputs
        outputs = {
          "eDP-1" = {
            scale = 2.2;
            position = {
              x = 0;
              y = 0;
            };
            mode = {
              width = 1920;
              height = 1080;
              refresh = null;
            };
          };
        };
      };
    }
  ];

  console.font = lib.mkForce "ter-v32b";

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = {
      DougTheDingo = "8d404b88-a379-4718-bc66-f81fdbfc4b49";
      Pr3stidigitator = "13ab3cbb-4a5d-467d-b150-a1b189f1c06e";
      JohnDestiny = "61b30a02-5b12-42e7-b4e2-5576520c413a";
    };
    serverProperties = {
      motd = "NixOS minecraft server";
      difficulty = 3;
      white-list = true;
      allow-cheats = false;
    };
  };

  services.acpid = {
    enable = true;

    handlers.ac-power = {
      event = "button/power.*";
      action = ''
        if [ -n "$WAYLAND_DISPLAY" ]; then
          # Wayland compositor (niri)
          /run/current-system/sw/bin/niri msg action power-off-monitors
        else
          # Plain TTY
          /run/current-system/sw/bin/setterm --blank force < /dev/tty2
        fi
      '';
    };
  };

  services.logind.settings.Login = {
    HandlePowerKey = lib.mkForce "ignore";
  };

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
