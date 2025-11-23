{
  pkgs,
  lib,
  config,
  username,
  ...
}: {
  imports = [
    ./desktop.nix
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-v16b";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs = {
    config.allowUnfree = true;
    # overlays = overlays;
  };

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # List services that you want to enable:

  services.displayManager.ly = {
    enable = true;
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  # Configure network proxy if necessary
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;

    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [22 47984 47989 47990 48010];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
