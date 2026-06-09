{inputs, ...}: {
  flake.homeModules.steam = {
    imports = [inputs.steam-config-nix.homeModules.default];
    programs.steam.config = {
      enable = true;
      closeSteam = true;
      defaultCompatTool = "proton_11";
      apps = {
        chaos-head-noah = {
          id = 1961950;
          compatTool = "proton_9";
        };
        steins-gate = {
          id = 412830;
          compatTool = "proton_8";
        };
        robotics-notes-elite = {
          id = 1111380;
          compatTool = "proton_9";
        };
        chaos-child = {
          id = 970570;
          compatTool = "proton_8";
        };
        steins-gate-0 = {
          id = 825630;
          compatTool = "proton_8";
        };
        robotics-notes-dash = {
          id = 1111390;
          compatTool = "proton_9";
        };

        counter-strike-2 = {
          id = 730;
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
