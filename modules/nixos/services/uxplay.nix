{
  flake.nixosModules.uxplay = {
    pkgs,
    config,
    lib,
    ...
  }: let
    cfg = config.services.uxplay;

    receiverName =
      if cfg.name != null
      then cfg.name
      else "UxPlay@${config.networking.hostName}";

    ports = [
      cfg.portBase
      (cfg.portBase + 1)
      (cfg.portBase + 2)
    ];

    args = ["-n" receiverName "-p" (toString cfg.portBase) "-vs" cfg.videoSink "-vsync" "no"];

    portsCsv = lib.concatMapStringsSep "," toString ports;

    openFirewallScript = pkgs.writeShellScript "uxplay-open-firewall" ''
      set -euo pipefail

      ${pkgs.nftables}/bin/nft insert rule ip filter nixos-fw \
        tcp dport { ${portsCsv} } jump nixos-fw-accept \
        comment \"uxplay-dynamic\"

      ${pkgs.nftables}/bin/nft insert rule ip filter nixos-fw \
        udp dport { ${portsCsv} } jump nixos-fw-accept \
        comment \"uxplay-dynamic\"

      ${pkgs.nftables}/bin/nft insert rule ip6 filter nixos-fw \
        tcp dport { ${portsCsv} } jump nixos-fw-accept \
        comment \"uxplay-dynamic\"

      ${pkgs.nftables}/bin/nft insert rule ip6 filter nixos-fw \
        udp dport { ${portsCsv} } jump nixos-fw-accept \
        comment \"uxplay-dynamic\"
    '';

    closeFirewallScript = pkgs.writeShellScript "uxplay-close-firewall" ''
      set -euo pipefail
      for family in ip ip6; do
        while handle="$(${pkgs.nftables}/bin/nft -a list chain "$family" filter nixos-fw \
          | ${pkgs.gnugrep}/bin/grep 'comment "uxplay-dynamic"' \
          | ${pkgs.gnused}/bin/sed -n 's/.* handle \([0-9]\+\)$/\1/p' \
          | ${pkgs.coreutils}/bin/head -n1)"; [ -n "$handle" ]; do
            ${pkgs.nftables}/bin/nft delete rule "$family" filter nixos-fw handle "$handle"
        done
      done
    '';

    uxplayWrapper = pkgs.writeShellApplication {
      name = "uxplay-wrapper";

      runtimeInputs = with pkgs; [
        uxplay
        coreutils
        findutils
        gnused
        gnugrep
      ];

      text = ''
        set -euo pipefail

        uid="$(id -u)"
        export XDG_RUNTIME_DIR="/run/user/$uid"

        if [ ! -d "$XDG_RUNTIME_DIR" ]; then
          echo "No XDG_RUNTIME_DIR found at $XDG_RUNTIME_DIR"
          echo "Log into a graphical session first."
          exit 1
        fi

        wayland_socket="$(
          find "$XDG_RUNTIME_DIR" \
            -maxdepth 1 \
            -type s \
            -name 'wayland-*' \
            | head -n 1
        )"

        if [ -z "$wayland_socket" ]; then
          echo "No Wayland socket found in $XDG_RUNTIME_DIR"
          echo "Are you logged into a Wayland session?"
          exit 1
        fi

        wayland_display="$(basename "$wayland_socket")"
        export WAYLAND_DISPLAY="$wayland_display"

        exec uxplay ${lib.escapeShellArgs args}
      '';
    };
  in {
    options.services.uxplay = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable uxplay systemd service.";
      };
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      portBase = lib.mkOption {
        type = lib.types.port;
        default = 35000;
      };
      videoSink = lib.mkOption {
        type = lib.types.str;
        default = "waylandsink";
      };
      dynamicFirewall = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Open configured UxPlay ports while uxplay service is running.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = with pkgs; [uxplay nftables];

      networking.firewall = lib.mkIf (!cfg.dynamicFirewall) {
        allowedUDPPorts = [5353] ++ ports;
        allowedTCPPorts = ports;
      };

      systemd.services."uxplay@" = {
        description = "UxPlay AirPlay receiver for %i";

        after = [
          "network-online.target"
          "graphical.target"
          "avahi-daemon.service"
        ];

        wants = [
          "network-online.target"
          "avahi-daemon.service"
        ];

        serviceConfig = {
          Type = "simple";

          # Instance user: uxplay@max.service -> User=max
          User = "%i";

          # Firewall scripts still run as root despite User=%i.
          ExecStartPre = lib.mkIf cfg.dynamicFirewall "+${openFirewallScript}";

          ExecStart = "${lib.getExe uxplayWrapper}";

          ExecStopPost = lib.mkIf cfg.dynamicFirewall "+${closeFirewallScript}";

          Restart = "no";
        };

        # Manual start only.
        wantedBy = lib.mkForce [];
      };
    };
  };
}
