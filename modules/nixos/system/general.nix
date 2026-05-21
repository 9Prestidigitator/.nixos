{
  flake.nixosModules.system-general = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options = {
      host = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "nixos";
          description = "Name of the host.";
        };
      };

      # Persistence options
      persist = {
        root = lib.mkOption {
          type = lib.types.str;
          default = "/persist";
          description = "Root path used by impermanence-backed persistence.";
        };
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "System directories to persist.";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "System files to persist.";
        };
        userDirs = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "User directories to persist for every normal user.";
        };
        userFiles = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [];
          description = "User files to persist for every normal user.";
        };
      };
    };

    config = {
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_7_0;

      time.timeZone = "US/Eastern";
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        earlySetup = true;
        font = lib.mkDefault "ter-v16b";
        packages = with pkgs; [terminus_font];
        keyMap = "us";
      };

      networking = {
        hostName = config.host.name;
        networkmanager.enable = true;
        firewall.enable = true;
      };
      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };

      environment.systemPackages = with pkgs; [dbus];
      services = {
        pipewire = {
          enable = true;
          jack.enable = true;
          pulse.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          extraConfig.pipewire."10-clock-rate"."context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = lib.mkDefault 128;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 1024;
          };
        };
        dbus.enable = true;
        power-profiles-daemon.enable = true;
        upower.enable = true;
        udisks2.enable = true;
        gvfs.enable = true;
        openssh = {
          enable = true;
          settings = {
            X11Forwarding = true;
            PermitRootLogin = "no";
            PasswordAuthentication = false;
          };
          openFirewall = true;
        };
        logind = {
          settings.Login = {
            HandleLidSwitch = lib.mkDefault "suspend";
            HandleLidSwitchDocked = lib.mkDefault "ignore";
            HandlePowerKey = lib.mkDefault "suspend";
          };
        };
        udev.extraRules = ''KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"'';
        printing.enable = true;
      };
    };
  };
}
