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
    inputs.tablet-mode.nixosModule
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    # inputs.nixos-hardware.nixosModules.common-cpu-intel
    # inputs.nixos-hardware.nixosModules.common-pc-ssd #microsoft-surface
  ];

  networking.hostName = "surface";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  desktop = {
    enable = true;
    musicprod.enable = false;
    gaming.enable = false;
    design.enable = false;
    comms.enable = false;
    media.enable = false;
    vm.enable = false;
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

  # systemd.services.iptsd = lib.mkForce {
  #   description = "Userspace daemon for Intel Precise Touch & Stylus";
  #   wantedBy = ["multi-user.target"];
  #   wants = ["dev-ipts-15.device"];
  #   after = ["dev-ipts-15.device"];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.iptsd}/bin/iptsd";
  #   };
  # };

  environment.systemPackages = with pkgs; [iptsd surface-control];
  services = {
    udev.packages = with pkgs; [iptsd surface-control];
    thermald = {
      enable = true;
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/linux-surface/linux-surface/${commit}/contrib/thermald/thermal-conf.xml";
        sha256 = "1xj70n9agy41906jgm4yjmsx58i7pzsizpvv3rkzq78k95qjfmc9";
      };
    };

    # from dev.ostylk.de/NixDistro/tablet-mode.git
    tablet-mode.enable = true;
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
    kernelParams = ["mem_sleep_default=deep" "kernel.nmi_watchdog=0" "vm.dirty_writeback_centisecs=1500"];
    # kernelPackages = pkgs.linuxPackages_surface;
    # kernelPackages = pkgs.linuxPackages_latest;
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

  powerManagement.cpuFreqGovernor = "performance";

  hardware.microsoft-surface.kernelVersion = "stable";
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
    logEvents = true;
    handlers.powerEvent = {
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
    # HandlePowerKeyLongPress = lib.mkForce "ignore";
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
