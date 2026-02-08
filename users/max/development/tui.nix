{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  syncRepo = import ./sync-repo.nix {inherit pkgs;};
in {
  imports = [
    inputs.neovim.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    # TUI
    vim
    emacs
    lazygit
    btop
  ];

  programs.Neovim.enable = true;

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-b";
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.nord
    ];
    extraConfig = ''
      bind-key h select-pane -L
      bind-key l select-pane -R
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key a last-window
      bind-key J swap-window -t -1 -d
      bind-key K swap-window -t +1 -d
      bind-key Tab switch-client -l
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -selection clipboard"
      set-option -g set-clipboard on
      set-option -g focus-events on
      set-option -g status-position top
      set-option -g status-style bg=default
    '';
  };
}
