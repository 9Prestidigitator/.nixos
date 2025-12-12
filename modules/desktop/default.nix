{pkgs, ...}
: {
  overwitch = pkgs.stdenv.mkDerivation rec {
    pname = "overwitch";
    version = "2.1.1";

    src = pkgs.fetchFromGitHub {
      owner = "dagargo";
      repo = "overwitch";
      rev = version;
      sha256 = "sha256-FnVM8QQBoQQxws0bIDoqcq4CGYVBgGEVFiN1QHuip34="; # Update this
    };

    nativeBuildInputs = with pkgs; [
      autoreconfHook
      pkg-config
      gettext
    ];

    buildInputs = with pkgs; [
      libusb1
      jack2
      libsamplerate
      libsndfile
      json-glib
      gtk4
      systemd
    ];

    # Uncomment for CLI-only build (no GTK)
    # configureFlags = [ "CLI_ONLY=yes" ];

    postInstall = ''
      # Install udev rules
      mkdir -p $out/lib/udev/rules.d
      cp udev/*.rules $out/lib/udev/rules.d/

      # Install systemd user service
      mkdir -p $out/lib/systemd/user
      cp systemd/overwitch.service $out/lib/systemd/user/
    '';

    meta = with pkgs.lib; {
      description = "JACK client for Overbridge 2 devices";
      homepage = "https://dagargo.github.io/overwitch/";
      license = licenses.gpl3Only;
      maintainers = [];
      platforms = platforms.linux;
      mainProgram = "overwitch";
    };
  };
}
