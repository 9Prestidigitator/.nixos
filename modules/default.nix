{
  pkgs,
  lib,
  inputs,
  overlays,
  config,
  ...
}: {
  imports = [
    ./desktop.nix
  ];

  desktop.enable = lib.mkDefault true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-v16b";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  nix = {
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
    settings.experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = overlays;
  };

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # List services that you want to enable:

  services = {
    displayManager.ly = {
      enable = true;
    };

    auto-cpufreq = {
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

    keyd = {
      enable = true;
      keyboards.default = {
        ids = [
          "046d:c069"
          "*"
          "-cb10:8256"
          "-3434:0430"
        ];
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
        };
      };
    };

    # Configure network proxy if necessary
    # Enable CUPS to print documents.
    printing.enable = true;

    pipewire = {
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
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        # PasswordAuthentication = false;
      };
      openFirewall = true;
    };
  };

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [22 47984 47989 47990 48010];
    # allowedUDPPortRanges = [
    #   {
    #     from = 47998;
    #     to = 48000;
    #   }
    #   {
    #     from = 8000;
    #     to = 8010;
    #   }
    # ];
  };
}
