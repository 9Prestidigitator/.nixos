{self, ...}: {
  flake.nixosModules.terminal-tools = {pkgs, ...}: {
    programs = {
      git.enable = true;
      starship = {
        enable = true;
        presets = ["nerd-font-symbols"];
      };
      # tmux = {
      #   enable = true;
      #   shortcut = "a";
      #   terminal = "tmux-256color";
      #   newSession = true;
      #   keyMode = "vi";
      #   customPaneNavigationAndResize = true;
      #   plugins = with pkgs; [
      #     tmuxPlugins.resurrect
      #     tmuxPlugins.continuum
      #     tmuxPlugins.catppuccin
      #     tmuxPlugins.yank
      #   ];
      #   escapeTime = 0;
      #   extraConfigBeforePlugins = ''
      #     set -g mouse on
      #     set -g focus-events on
      #     set -g history-limit 20000
      #     set -g display-time 4000
      #
      #     bind-key -n C-p previous-window
      #     bind-key -n C-n next-window
      #     bind-key a last-window
      #     bind-key P swap-window -t -1 -d
      #     bind-key N swap-window -t +1 -d
      #     bind-key Tab switch-client -l
      #
      #     set-option -g set-clipboard on
      #     set-option -g status-position top
      #     setw -g aggressive-resize on
      #
      #     set -g @continuum-restore 'on'
      #
      #     set -g @catppuccin_flavor "mocha"
      #     set -g @catppuccin_window_status_style "basic"
      #     set -g @catppuccin_status_background "none"
      #     set -g @catppuccin_window_default_text " #W"
      #     set -g @catppuccin_window_current_text " #W"
      #     set -g @catppuccin_window_text " #W"
      #   '';
      #   extraConfig = ''
      #     set -g status-left-length 100
      #     set -g status-left ""
      #
      #     set -g status-right-length 100
      #     set -g status-right "#{E:@catppuccin_status_session}"
      #     set -ag status-right "#{E:@catppuccin_status_uptime}"
      #     set -ag status-right "#{E:@catppuccin_status_date_time}"
      #     set -agF status-right "#{E:@catppuccin_status_host}"
      #   '';
      # };
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
