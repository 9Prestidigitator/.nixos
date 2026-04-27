{self, ...}: {
  flake.nixosModules.terminal-tools = {pkgs, ...}: {
    programs = {
      git.enable = true;
      starship = {
        enable = true;
        presets = ["nerd-font-symbols"];
      };
    };
    environment.systemPackages = with pkgs; [
      bashInteractive
      self.packages.${pkgs.system}.tmux
      btop
      vim
      lazygit
      ripgrep
      fd
      fzf
      tree
      yazi
      fd
      delta
      calc
      just
      wget
      zip
      unrar
      unzip
    ];
  };
}
