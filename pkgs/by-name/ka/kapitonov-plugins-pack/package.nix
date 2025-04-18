{
  lib,
  stdenv,
  fetchFromGitHub,
  faust,
  meson,
  ninja,
  pkg-config,
  boost,
  cairo,
  fftw,
  ladspa-sdk,
  libxcb,
  lv2,
  xcbutilwm,
  xorg,
  zita-convolver,
  zita-resampler,
}:

stdenv.mkDerivation rec {
  pname = "kapitonov-plugins-pack";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "olegkapitonov";
    repo = "kapitonov-plugins-pack";
    tag = version;
    sha256 = "1mxi7b1vrzg25x85lqk8c77iziqrqyz18mqkfjlz09sxp5wfs9w4";
  };

  nativeBuildInputs = [
    faust
    meson
    ninja
    pkg-config
  ];

  buildInputs = [
    boost
    cairo
    fftw
    ladspa-sdk
    libxcb
    lv2
    xcbutilwm
    xorg.xcbutil
    zita-convolver
    zita-resampler
  ];

  meta = with lib; {
    description = "Set of LADSPA and LV2 plugins for guitar sound processing";
    homepage = "https://github.com/olegkapitonov/Kapitonov-Plugins-Pack";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ magnetophon ];
  };
}
