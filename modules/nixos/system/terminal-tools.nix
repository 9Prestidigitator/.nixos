{self, ...}: {
  flake.nixosModules.terminal-tools = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    programs = {
      git.enable = true;
      starship = {
        enable = true;
        presets = ["nerd-font-symbols"];
      };
    };

    environment.systemPackages = with pkgs; [
      bashInteractive

      self.packages.${system}.tmux
      btop

      vim
      lazygit
      yazi

      fd
      fzf
      just
      ripgrep
      nix-search-tv
      delta
      tree
      calc
      wget

      zip
      unrar
      unzip

      cryptsetup
      gptfdisk
      usbutils
      pciutils

      brotli
      ntfs3g
      gvfs
      p7zip
      parted

      zenity
      pkg-config
      steam-run
      appimage-run
    ];

    persist = {
      userDirs = [
        ".config/lazygit"
        ".local/state/lazygit"
        ".config/btop"
        ".tmux"
      ];
    };
  };
}
