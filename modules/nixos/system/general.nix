{
  flake.nixosModules.system-general = {
    pkgs,
    lib,
    config,
    ...
  }: {
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
            support32Bit = lib.mkForce false; # TODO(max): This hasn't been cached yet :(
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

      systemd.sleep.settings.Sleep = {
        AllowHibernation = "no";
        AllowSuspendThenHibernate = "no";
      };

      persist.directories = [
        # "/etc/cups"
        "/var/lib/cups"
      ];
    };
  };
}
