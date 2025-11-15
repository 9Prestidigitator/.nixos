# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          canTouchEfiVariables = true;
          useOSProber = true;
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "threadirqs"
    ];
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "realtime"]; # Enable ‘sudo’ for the user.
  };

  # programs.hyprland.enable = true;

  programs.niri.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "inomeogfingihgjfjlpeplalcfajhgai"
      "dbepggeogbaibhgnhhndojpepiihcmeb"
      "hkgfoiooedgoejojocmhlaklaeopbecg"
      "gebbhagfogifgggkldgodflihgfeippi"
    ];
    extraOpts = {"WaylandWpColorManagerV1" = false;};
  };

  programs.nix-ld.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # CLI
    git
    tree
    wget
    starship
    fastfetch
    ripgrep
    unzip
    fd

    # TUI
    vim
    btop
    lazygit

    # GUI
    brave
    kitty
    qjackctl

    # AUDIO
    yabridge
    yabridgectl

    # Development
    gcc
    rustup
    python315
    nodejs_24
    dotnetCorePackages.sdk_9_0-bin
    nixd

    # Utilities
    usbutils
    pciutils
    pkg-config
    brotli
    openssl
    parted
    xdg-desktop-portal-gnome
    xwayland-satellite

    # Fonts
    nerd-fonts.hack
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.displayManager.ly = {
    enable = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?
}
