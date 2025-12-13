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
      pkg-config
      automake
      autoconf
      autoreconfHook
      libtool
      gettext
    ];

    buildInputs = with pkgs; [
      libusb1
      libsamplerate
      libsndfile
      json-glib
      jack2
      gtk4
      systemd
    ];

    # Uncomment for CLI-only build (no GTK)
    configureFlags = ["--with-systemduserconfdir=${placeholder "out"}/lib/systemd/user"];

    proConfigure = ''
      autoreconf --intall
    '';

    installFlags = [
      "sysconfdir=$(out)/etc"
      "udevdir=$(out)/lib/udev"
    ];

    # postInstall = ''
    #   # Install udev rules
    #   mkdir -p $out/lib/udev/rules.d
    #   cp udev/*.rules $out/lib/udev/rules.d/
    #
    #   # Install systemd user service
    #   mkdir -p $out/lib/systemd/user
    #   cp systemd/overwitch.service $out/lib/systemd/user/
    # '';

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
