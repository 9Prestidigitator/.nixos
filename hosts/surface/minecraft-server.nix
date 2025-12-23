{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      osage = {
        enable = true;
        package = pkgs.paperServers.paper;
        operators = {
          Pr3stidigitator = "13ab3cbb-4a5d-467d-b150-a1b189f1c06e";
        };
        whitelist = {
          Pr3stidigitator = "13ab3cbb-4a5d-467d-b150-a1b189f1c06e";
          DougTheDingo = "8d404b88-a379-4718-bc66-f81fdbfc4b49";
          JohnDestiny = "61b30a02-5b12-42e7-b4e2-5576520c413a";
          angerypossum2 = "eee1a468-48cc-460a-a993-b9604049d3d7";
        };
        serverProperties = {
          motd = "NixOS minecraft server";
          difficulty = 3;
          online-mode = true;
          white-list = true;
          allow-cheats = false;
        };
      };
    };
  };
}
