{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    packages.tmux = inputs.wrappers.wrappers.tmux.wrap {
      inherit pkgs;
      package = pkgs.tmux;
      prefix = "C-a";
      terminal = "tmux-256color";
      mouse = true;
      historyLimit = 20000;
      escapeTime = 0;
      secureSocket = true;
      historyLimit = 20000;
      statusKeys = "vi";
      modeKeys = "vi";
      configBefore = ''
        set -g focus-events on
        set -g display-time 4000

        new-session -A -s 0

        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        bind-key -n C-p previous-window
        bind-key -n C-n next-window
        bind-key a last-window
        bind-key P swap-window -t -1 -d
        bind-key N swap-window -t +1 -d
        bind-key Tab switch-client -l

        set-option -g set-clipboard on
        set-option -g status-position top
        setw -g aggressive-resize on

        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_window_status_style "basic"
        set -g @catppuccin_status_background "none"
        set -g @catppuccin_window_default_text " #W"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W"
      '';

      plugins = [
        {
          plugin = pkgs.tmuxPlugins.resurrect;
          after = ["resurrect"];
          configAfter = ''
            set -g @continuum-restore 'on'
          '';
        }
        {plugin = pkgs.tmuxPlugins.continuum;}
        {plugin = pkgs.tmuxPlugins.catppuccin;}
        {plugin = pkgs.tmuxPlugins.yank;}
      ];
      configAfter = ''
        set -g status-left-length 100
        set -g status-left ""

        set -g status-right-length 100
        set -g status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
        set -agF status-right "#{E:@catppuccin_status_host}"
      '';
    };
  };
}
