{
  lib,
  pkgs,
  ...
}: let
  waywallen = pkgs.appimageTools.wrapAppImage rec {
    pname = "waywallen";
    version = "0.4.3";
    src = pkgs.appimageTools.extract {
      inherit pname version;
      src = pkgs.fetchurl {
        url = "https://github.com/waywallen/waywallen/releases/download/v${version}/waywallen-${version}-x86_64.AppImage";
        hash = "sha256-eMaUjkoUEt3pj/egM+hoKkRh5nrB6oNo2UEsml8Sl04=";
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
    version = "0.4.0";
    src = pkgs.fetchurl {
      url = "https://github.com/waywallen/waywallen-display/releases/download/v${version}/waywallen-kde-${version}-x86_64-embed.zip";
      hash = "sha256-CBGTomn7nQ9NQ/7mg+m+S70x8Dy/7imUBhYUT2SVeNY=";
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
    version = "0.3.0";
    src = pkgs.fetchurl {
      url = "https://github.com/waywallen/open-wallpaper-engine/releases/download/v${version}/org.waywallen.open-wallpaper-engine-${version}-linux-x86_64.zip";
      hash = "sha256-LsU6867nf1Y1DpWWRryP3CVzIMpkAALvzX3o4ySudYk=";
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
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  persist.directories = [
    ".config/waywallen"
    ".local/share/waywallen"
    ".local/state/waywallen"
  ];
}
