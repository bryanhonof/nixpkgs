{
  lib,
  buildGoModule,
  fetchFromGitHub,
  docker,
}:

buildGoModule rec {
  pname = "fn";
  version = "0.6.40";

  src = fetchFromGitHub {
    owner = "fnproject";
    repo = "cli";
    tag = version;
    hash = "sha256-myLoLpEiyVTDsFx97AFiS9KNAOQd7NU+W8PJl95a7k0=";
  };

  vendorHash = null;

  subPackages = [ "." ];

  buildInputs = [
    docker
  ];

  preBuild = ''
    export HOME=$TMPDIR
  '';

  postInstall = ''
    mv $out/bin/cli $out/bin/fn
  '';

  meta = with lib; {
    description = "Command-line tool for the fn project";
    mainProgram = "fn";
    homepage = "https://fnproject.io";
    license = licenses.asl20;
    maintainers = [ maintainers.c4605 ];
  };
}
