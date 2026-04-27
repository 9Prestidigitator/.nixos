{inputs, ...}: {
  flake.nixosModules.system-general = {pkgs, lib, ...}: let
    pkgsMaster = import inputs.nixpkgs-master {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  in {
    boot.kernelPackages = lib.mkDefault pkgsMaster.linuxKernel.packages.linux_7_0;

    time.timeZone = "US/Eastern";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      earlySetup = true;
      font = lib.mkDefault "ter-v16b";
      packages = with pkgs; [terminus_font];
      keyMap = "us";
    };

    networking.firewall.enable = true;
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
        alsa.enable = true;
        alsa.support32Bit = true;
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
  };
}
