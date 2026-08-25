{
  flake.homeModules.fastfetch = {pkgs, ...}: let
    logoLarge = pkgs.fetchurl {
      url = "https://gitlab.com/ntgn/ascii-art/-/raw/main/src/nixos_wrath.txt";
      hash = "sha256-dsZU4FzxdsJWRnNmCiruojZQAL01jFOQsj13hoSNvTY=";
    };
    logoSmall = pkgs.fetchurl {
      url = "https://gitlab.com/ntgn/ascii-art/-/raw/main/src/nixos_logo.txt";
      hash = "sha256-kr3HHVkuBxHoXakIgcotcr0/NtLUAQWutu+gxhZ4s1g=";
    };
  in {
    programs = {
      fastfetch = {
        enable = true;
        settings = {
          display = {
            separator = "";
          };
          modules = [
            "break"
            {
              type = "custom";
              format = "┌─────────────────────────────────────────────────────┐";
              color = "white";
            }
            {
              type = "title";
              key = "                       ";
            }
            "break"
            {
              type = "os";
              key = "┌󰌽  ";
            }
            {
              type = "kernel";
              key = "└  ";
            }
            "break"
            {
              type = "uptime";
              key = "┌󰥔  ";
            }
            {
              type = "packages";
              key = "└󰏖  ";
            }
            "break"
            {
              type = "cpu";
              key = "┌  ";
            }
            {
              type = "gpu";
              key = "├󰍛  ";
            }
            {
              type = "memory";
              key = "├󰍛  ";
            }
            {
              type = "disk";
              key = "└  ";
            }
            {
              type = "custom";
              format = "└─────────────────────────────────────────────────────┘";
              color = "white";
            }
          ];
        };
      };

      bash.initExtra = ''
        clear
        [ $(tput cols) -ge 120 ] && fastfetch --file-raw "${logoLarge}" --logo-padding-left $((($(tput cols) - 120) / 2))
        [ $(tput cols) -ge 78 ] && [ $(tput cols) -lt 110 ] && fastfetch --file-raw "${logoSmall}"  --logo-padding-top 3 --logo-padding-left $((($(tput cols) - 78) / 2)) --logo-padding-right 2
        [ $(tput cols) -lt 78 ] && fastfetch --logo none
      '';
    };

    persist = {
      directories = [".local/share/zoxide"];
      files = [".bash_history"];
    };
  };
}
