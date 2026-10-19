{inputs, ...}: {
  flake.homeModules.steam = {pkgs, ...}: {
    imports = [inputs.steam-config-nix.homeModules.default];

    home.packages = [
      (pkgs.writeShellApplication {
        name = "civ5-vox-populi";
        runtimeInputs = [pkgs.python3 pkgs.gdown pkgs.curl];
        text = ''
          exec python3 ${./vox-populi-installer.py} "$@"
        '';
      })
    ];

    programs.steam.config = {
      enable = true;
      # closeSteam = true;
      defaultCompatTool = "proton_11";
      apps = {
        "1961950" = {
          name = "chaos-head-noah";
          compatTool = "proton_9";
        };
        "412830" = {
          name = "steins-gate";
          compatTool = "proton_8";
        };
        "1111380" = {
          name = "robotics-notes-elite";
          compatTool = "proton_9";
        };
        "970570" = {
          name = "chaos-child";
          compatTool = "proton_8";
        };
        "825630" = {
          name = "steins-gate-0";
          compatTool = "proton_8";
        };
        "1111390" = {
          name = "robotics-notes-dash";
          compatTool = "proton_9";
        };

        "730" = {
          name = "counter-strike-2";
          rawLaunchOptions = "%command% -sdlaudiodriver pulse";
        };

        "8930" = {
          name = "civilization-5";
          compatTool = "GE-Proton";
          rawLaunchOptions = "PROTON_ENABLE_WAYLAND=1 %command%";
        };
      };
    };

    persist.directories = [
      ".steam"
      ".local/share/Steam"
      ".local/share/steam"
    ];
  };
}
