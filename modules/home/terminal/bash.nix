{
  flake.homeModules.bash = {
    config,
    osConfig,
    ...
  }: {
    programs = {
      bash = {
        enable = true;
        historyFile = "$HOME/.bash_history";
        historySize = 100000;
        historyFileSize = 100000;
        initExtra = ''
          shopt -s histappend
          PROMPT_COMMAND="history -a; history -n''${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
        '';
      };

      zoxide.enable = true;
    };

    home = {
      shellAliases = {
        ls = "ls -a --color=auto";
        fman = "compgen -c | sort -hr | fzf | xargs man";

        # This is useful for impermanent systems
        lsblk = "lsblk -e7 -o NAME,SIZE,TYPE,FSTYPE,LABEL,UUID,MOUNTPOINT";

        tm = "tmux a || tmux";

        leet-lsp = "nix develop ${config.home.homeDirectory}/.nixos#python -c sh -c 'nvim leetcode.nvim'";
        leet = "nvim leetcode.nvim";

        nhre = "nh os switch ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
        nhbo = "nh os boot ${config.home.homeDirectory}/.nixos -H ${osConfig.networking.hostName}";
        nixre = "sudo nixos-rebuild switch ${config.home.homeDirectory}/.nixos#${osConfig.networking.hostName}";
        nixup = "nix flake update";

        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";

        ds = "nix develop";
        ds-nix = "nix develop ${config.home.homeDirectory}/.nixos#nix";
        ds-md = "nix develop ${config.home.homeDirectory}/.nixos#markdown";
        ds-cpp = "nix develop ${config.home.homeDirectory}/.nixos#cpp";
        ds-cs = "nix develop ${config.home.homeDirectory}/.nixos#csharp";
        ds-py = "nix develop ${config.home.homeDirectory}/.nixos#python";
        ds-max = "nix develop ${config.home.homeDirectory}/.nixos#max";
      };
    };

    persist = {
      directories = [".local/share/zoxide"];
      files = [".bash_history"];
    };
  };
}
