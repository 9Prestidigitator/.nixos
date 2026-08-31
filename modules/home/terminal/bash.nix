{self, ...}: {
  flake.homeModules.bash = {
    import = [self.homeModules.aliases];

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

    persist = {
      directories = [".local/share/zoxide"];
      files = [".bash_history"];
    };
  };
}
