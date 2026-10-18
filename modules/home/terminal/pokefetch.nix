{
  flake.homeModules.pokefetch = {
    lib,
    options,
    pkgs,
    ...
  }: let
    pokefetch = pkgs.writeShellApplication {
      name = "pokefetch";
      runtimeInputs = with pkgs; [
        fastfetch
        ncurses
        perl
        pokeget-rs
      ];
      text = ''
        columns="$(tput cols)"
        if [ "$columns" -lt 78 ]; then
          exec fastfetch --logo none
        fi

        logo_args=(--file-raw - --logo-padding-right 2)
        if [ "$columns" -lt 120 ]; then
          logo_args+=(--logo-padding-top 3)
        fi

        pokeget random --hide-name |
          fastfetch --pipe false "''${logo_args[@]}" |
          POKEFETCH_COLUMNS="$columns" perl -CS -e '
            my @lines = <STDIN>;
            my $width = 0;

            if (@lines > 1) {
              my $visible = $lines[-1];
              $visible =~ s/\e\[[0-?]*[ -\/]*[@-~]//g;

              if ($visible eq "") {
                my $trailing_ansi = pop @lines;
                $lines[-1] =~ s/(\r?\n)\z/$trailing_ansi$1/;
              }
            }

            for my $line (@lines) {
              my $visible = $line;
              $visible =~ s/\e\[[0-?]*[ -\/]*[@-~]//g;
              $visible =~ s/\r?\n\z//;
              my $line_width = length $visible;
              $width = $line_width if $line_width > $width;
            }

            my $padding = int(($ENV{POKEFETCH_COLUMNS} - $width) /2);
            $padding = 0 if $padding < 0;
            print((" " x $padding), $_) for @lines;
          '
      '';
    };
  in {
    config = lib.mkMerge [
      {
        home.packages = [pokefetch];
        programs = {
          fastfetch = {
            enable = true;
            settings = {
              display = {
                separator = "";
                color.output = "white";
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
                  color = "magenta";
                }
                "break"
                {
                  type = "os";
                  key = "┌󰌽  ";
                  color = "blue";
                }
                {
                  type = "kernel";
                  key = "└  ";
                  color = "blue";
                }
                "break"
                {
                  type = "uptime";
                  key = "┌󰥔  ";
                  color = "green";
                }
                {
                  type = "packages";
                  key = "└󰏖  ";
                  color = "green";
                }
                "break"
                {
                  type = "cpu";
                  key = "┌  ";
                  color = "red";
                }
                {
                  type = "gpu";
                  key = "├󰍛  ";
                  color = "red";
                }
                {
                  type = "memory";
                  key = "├󰍛  ";
                  color = "orange";
                }
                {
                  type = "disk";
                  key = "└  ";
                  color = "yellow";
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
            pokefetch
          '';

          fish.interactiveShellInit = ''
            clear
            pokefetch
          '';
        };
      }

      (lib.optionalAttrs (lib.hasAttrByPath ["stylix" "targets" "fastfetch" "enable"] options) {stylix.targets.fastfetch.enable = false;})
    ];
  };
}
