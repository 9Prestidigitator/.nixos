{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.kwin-zones = pkgs.stdenv.mkDerivation {
      pname = "kwin-zones";
      version = "1.0.14";

      src = pkgs.fetchFromGitHub {
        owner = "KDE";
        repo = "kwin-zones";
        rev = "17bc66751affe0e3a4644cd9fc30aa89031b1e2a";
        hash = "sha256-IyjmgCRDatgngcrzNcktreWGqQNWSTOekgnGS/0c96g=";
      };

      nativeBuildInputs = with pkgs; [
        cmake
        ninja
        pkg-config
        kdePackages.extra-cmake-modules
        kdePackages.wrapQtAppsHook
      ];
      buildInputs = with pkgs; [
        kdePackages.kwin
        kdePackages.kconfig
        kdePackages.qtbase
        kdePackages.qtdeclarative
        kdePackages.qtwayland
        wayland
        wayland-protocols
      ];

      # Installs the native KWin plugin and the org.kde.zones QML client module.
      dontWrapQtApps = true;
      meta = {
        description = "Experimental xx-zones Wayland protocol support for KWin";
        homepage = "https://invent.kde.org/automotive/kwin-zones";
        license = lib.licenses.gpl2Plus;
        platforms = lib.platforms.linux;
      };
    };
  };
}
