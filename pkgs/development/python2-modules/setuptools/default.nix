{
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  python,
  bootstrapped-pip,
  lib,
  pipInstallHook,
  setuptoolsBuildHook,
}:

let
  pname = "setuptools";
  version = "44.0.0";

  # Create an sdist of setuptools
  sdist = stdenv.mkDerivation rec {
    name = "${pname}-${version}-sdist.tar.gz";

    src = fetchFromGitHub {
      owner = "pypa";
      repo = pname;
      tag = "v${version}";
      sha256 = "0z3q0qinyp1rmnxkw3y5f6nbsxhqlfq5k7skfrqa6ymb3zr009y1";
      name = "${pname}-${version}-source";
    };

    patches = [
      ./tag-date.patch
    ];

    buildPhase = ''
      ${python.pythonOnBuildForHost.interpreter} bootstrap.py
      ${python.pythonOnBuildForHost.interpreter} setup.py sdist --formats=gztar

      # Here we untar the sdist and retar it in order to control the timestamps
      # of all the files included
      tar -xzf dist/${pname}-${version}.post0.tar.gz -C dist/
      tar -czf dist/${name} -C dist/ --mtime="@$SOURCE_DATE_EPOCH" ${pname}-${version}.post0
    '';

    installPhase = ''
      echo "Moving sdist..."
      mv dist/${name} $out
    '';
  };
in
buildPythonPackage {
  inherit pname version;
  # Because of bootstrapping we don't use the setuptoolsBuildHook that comes with format="setuptools" directly.
  # Instead, we override it to remove setuptools to avoid a circular dependency.
  # The same is done for pip and the pipInstallHook.
  format = "other";

  src = sdist;

  nativeBuildInputs = [
    bootstrapped-pip
    (pipInstallHook.override { pip = null; })
    (setuptoolsBuildHook.override {
      setuptools = null;
      wheel = null;
    })
  ];

  preBuild = lib.optionalString (!stdenv.hostPlatform.isWindows) ''
    export SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0
  '';

  pipInstallFlags = [ "--ignore-installed" ];

  # Adds setuptools to nativeBuildInputs causing infinite recursion.
  catchConflicts = false;

  # Requires pytest, causing infinite recursion.
  doCheck = false;

  meta = with lib; {
    description = "Utilities to facilitate the installation of Python packages";
    homepage = "https://pypi.python.org/pypi/setuptools";
    license = with licenses; [
      psfl
      zpl20
    ];
    platforms = python.meta.platforms;
    priority = 10;
  };
}
