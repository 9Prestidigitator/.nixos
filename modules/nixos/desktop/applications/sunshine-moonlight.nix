{
  flake.nixosModules.sunshine-moonlight = {
    pkgs,
    lib,
    ...
  }: {
    services.sunshine = {
      enable = true;
      autoStart = lib.mkDefault false;
      capSysAdmin = true;
      openFirewall = true;
    };

    environment.systemPackages = with pkgs; [moonlight-qt];

    persist.userDirs = [
      ".config/Moonlight Game Streaming Project"
      ".config/sunshine"
    ];
  };
}
