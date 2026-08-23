{inputs, ...}: {
  flake.homeModules.steam = {
    imports = [inputs.steam-config-nix.homeModules.default];
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
          launchOptionsStr = "%command% -sdlaudiodriver pulse";
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
