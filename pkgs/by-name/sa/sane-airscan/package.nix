{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  avahi,
  libjpeg,
  libpng,
  libtiff,
  libxml2,
  gnutls,
  sane-backends,
}:
stdenv.mkDerivation rec {
  pname = "sane-airscan";
  version = "0.99.33";

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];
  buildInputs = [
    avahi
    gnutls
    libjpeg
    libpng
    libxml2
    libtiff
    sane-backends
  ];

  src = fetchFromGitHub {
    owner = "alexpevzner";
    repo = pname;
    tag = version;
    sha256 = "sha256-qZ7j76cwJQxGXbgIkV2bYt7puG0lSEw/d6d3fw19TCk=";
  };

  meta = with lib; {
    homepage = "https://github.com/alexpevzner/sane-airscan";
    description = "Scanner Access Now Easy - Apple AirScan (eSCL) driver";
    mainProgram = "airscan-discover";
    longDescription = ''
      sane-airscan: Linux support of Apple AirScan (eSCL) compatible document scanners.
    '';
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ zaninime ];
  };
}
