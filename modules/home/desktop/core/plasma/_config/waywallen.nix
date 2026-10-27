{
  lib,
  pkgs,
  ...
}: let
  waywallen = pkgs.appimageTools.wrapAppImage rec {
    pname = "waywallen";
    version = "0.5.0";
    src = pkgs.appimageTools.extract {
      inherit pname version;
      src = pkgs.fetchurl {
        url = "https://github.com/waywallen/waywallen/releases/download/v${version}/waywallen-${version}-x86_64.AppImage";
        hash = "sha256-5iFsX//HBWEisQXldFlQye53cQ4pSmO2h8Szhx4ZAIM=";
      };
    };
    extraPkgs = pkgs: with pkgs; [lz4];
    extraInstallCommands = ''
      install -Dm644 ${src}/org.waywallen.waywallen.desktop $out/share/applications/org.waywallen.waywallen.desktop
      mkdir -p $out/share/icons
      cp -r ${src}/usr/share/icons/hicolor $out/share/icons
    '';
    meta.platforms = ["x86_64-linux"];
  };

  waywallen-display = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "waywallen-display";
    version = "0.4.3";
    src = pkgs.fetchurl {
      url = "https://github.com/waywallen/waywallen-display/releases/download/v${version}/waywallen-kde-${version}-x86_64-embed.zip";
      hash = "sha256-3Vu5k04sD7Dq0UlgVxzT+4S2bb3jJmzvgeSrfqjlHts=";
    };
    nativeBuildInputs = [pkgs.unzip pkgs.autoPatchelfHook];
    buildInputs = [pkgs.kdePackages.qtbase pkgs.kdePackages.qtdeclarative];
    strictDeps = true;
    __structuredAttrs = true;
    dontWrapQtApps = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/plasma/wallpapers/org.waywallen.kde
      cp -r * $out/share/plasma/wallpapers/org.waywallen.kde
      runHook postInstall
    '';
    meta.platforms = ["x86_64-linux"];
  };

  open-wallpaper-engine = pkgs.stdenv.mkDerivation rec {
    pname = "waywallen-open-wallpaper-engine";
    version = "0.3.1";
    src = pkgs.fetchurl {
      url = "https://github.com/waywallen/open-wallpaper-engine/releases/download/v${version}/org.waywallen.open-wallpaper-engine-${version}-linux-x86_64.zip";
      hash = "sha256-vW18mowshRWKalH3wkFalW/0PGbKZ7yL7VbFji5h39g=";
    };
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      ${pkgs.unzip}/bin/unzip -q "$src" -d "$out"
      runHook postInstall
    '';
    meta.platforms = ["x86_64-linux"];
  };
in {
  home.packages = [waywallen waywallen-display];

  xdg.dataFile."waywallen/plugins/org.waywallen.open-wallpaper-engine".source = open-wallpaper-engine;

  programs.plasma.workspace.wallpaperCustomPlugin.plugin = "org.waywallen.kde";

  systemd.user.services.waywallen = {
    Unit = {
      Description = "Waywallen wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe waywallen} --no-ui --no-tray --display-backend kde-plasma";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  persist.directories = [
    ".config/waywallen"
    ".local/share/waywallen"
    ".local/state/waywallen"
  ];
}
