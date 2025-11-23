{
  username,
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./tui.nix
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls -a --color=auto";
      nv = "nvim";
      tm = "tmux a || tmux";
      nrs = "sudo nixos-rebuild switch";
      nixup = "sudo nixos-rebuild switch --impure --flake .";
    };
    initExtra = ''
      fastfetch
      eval "$(starship init bash)"
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  home.packages = with pkgs; [
    # CLI
    git
    tree
    wget
    starship
    fastfetch
    ripgrep
    unzip
    fd

    # Development
    gcc
    rustup
    python315
    uv
    nodejs_24
    dotnetCorePackages.sdk_9_0-bin
    nixd
  ];
}
