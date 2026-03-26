{inputs, ...}: {
  flake.nixosModules.systemGeneral = { pkgs, lib, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_zen;
    time.timeZone = "US/Eastern";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      earlySetup = true;
      font = "ter-v16b";
      packages = with pkgs; [terminus_font];
      keyMap = "us";
      # useXkbConfig = true; # use xkb.options in tty.
    };

    programs = {
      nh.enable = true;
      nix-ld.enable = true;
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
          "default.clock.rate" = 44100;
          "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 64;
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
      udev.extraRules = ''KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"'';
    };

    networking.firewall.enable = true;
    printing.enable = true;

    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        inputs.self.overlays.default
        inputs.audio-nix.overlays.default
        inputs.niri.overlays.niri
      ];
    };
    nix = {
      gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
      };
      settings = {
        experimental-features = ["nix-command" "flakes"];
        allowed-users = ["@wheel"];
        trusted-users = ["@wheel" "nixremote"];
      };
    };
    system.stateVersion = "25.11";
  };
}
