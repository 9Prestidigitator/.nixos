{
  lib,
  appimageTools,
  fetchurl,
}:
appimageTools.wrapType2 {
  pname = "eden";
  version = "0.0.4"; # Eden doesn't publish fixed versions

  src = fetchurl {
    url = "https://github.com/eden-emulator/Releases/releases/download/v0.0.4/Eden-Linux-v0.0.4-amd64-gcc-standard.AppImage";
    sha256 = "sha256-7ZgPXuhF2MWlj3FDwaP74rfRgfbRI43Hw6qvdrzxMdQ=";
  };

  extraInstallCommands = ''
    # Normalize desktop file name if one is provided
    if [ -d "$out/share/applications" ]; then
      for f in $out/share/applications/*.desktop; do
        mv "$f" "$out/share/applications/eden.desktop"
      done
    fi
  '';

  meta = with lib; {
    description = "Eden Nintendo Switch emulator";
    homepage = "https://eden-emu.dev/";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
