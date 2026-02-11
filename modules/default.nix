{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    ./desktop
    ./theme.nix
  ];

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

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.self.overlays.default
      inputs.audio-nix.overlays.default
    ];
  };

  programs.nh.enable = true;

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "ter-v16b";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # List services that you want to enable:
  services = {
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

    # Enable CUPS to print documents.
    printing.enable = true;

    power-profiles-daemon.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    dbus.enable = true;

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    keyd = {
      enable = true;
      keyboards.default = {
        ids = [
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
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.firewall = {
    enable = true;
  };

  home-manager.sharedModules = [
    {
      programs.home-manager.enable = true;
    }
  ];
}
