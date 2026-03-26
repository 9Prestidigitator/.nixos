{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  automake,
  autoconf,
  autoreconfHook,
  libtool,
  gettext,
  libusb1,
  libsamplerate,
  libsndfile,
  json-glib,
  jack2,
  gtk4,
  systemd,
  ...
}: stdenv.mkDerivation rec {
  pname = "overwitch";
  version = "2.2";

  src = fetchFromGitHub {
    owner = "dagargo";
    repo = "overwitch";
    rev = version;
    sha256 = "sha256-EYT5m4N9kzeYaOcm1furGGxw1k+Bw+m+FvONVZN9ohk="; # Update this
  };

  nativeBuildInputs = [
    pkg-config
    automake
    autoconf
    autoreconfHook
    libtool
    gettext
  ];

  buildInputs = [
    libusb1
    libsamplerate
    libsndfile
    json-glib
    jack2
    gtk4
    systemd
  ];

  postInstall = ''
    # Install udev rules
    mkdir -p $out/lib/udev/rules.d
    cp udev/*.rules $out/lib/udev/rules.d/

    # Install systemd user service
    mkdir -p $out/lib/systemd/user
    cp systemd/overwitch.service $out/lib/systemd/user/
  '';

  meta = with lib; {
    description = "JACK client for Overbridge 2 devices";
    homepage = "https://dagargo.github.io/overwitch/";
    license = licenses.gpl3Only;
    maintainers = [];
    platforms = platforms.linux;
    mainProgram = "overwitch";
  };
}
