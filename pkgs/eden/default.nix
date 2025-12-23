{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "eden";
  version = "0.0.4";

  src = fetchurl {
    url = "https://github.com/eden-emulator/Releases/releases/download/v0.0.4/Eden-Linux-v0.0.4-amd64-gcc-standard.AppImage";
    sha256 = "sha256-7ZgPXuhF2MWlj3FDwaP74rfRgfbRI43Hw6qvdrzxMdQ=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version;
    src = src;

    extraInstallCommands = ''
      # Install desktop file with correct name
      install -m 444 -D ${appimageContents}/dev.eden_emu.eden.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'

      # Install icon
      install -m 444 -D ${appimageContents}/dev.eden_emu.eden.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg
    '';

    meta = with lib; {
      description = "Eden Nintendo Switch emulator";
      homepage = "https://eden-emu.dev/";
      license = licenses.unfreeRedistributable;
      platforms = platforms.linux;
      mainProgram = "eden";
    };
  }
