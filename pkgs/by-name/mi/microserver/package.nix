{
  lib,
  stdenv,
  fetchFromGitHub,
  rustPlatform,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "microserver";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "robertohuertasm";
    repo = "microserver";
    tag = "v${version}";
    sha256 = "sha256-VgzOdJ1JLe0acjRYvaysCPox5acFmc4VD2f6HZWxT8M=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-IPJJ9kv7gf5l7Y2JLCLjkNFao42h/VmkTd3LF5BCMLU=";

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin (
    with darwin.apple_sdk.frameworks; [ Security ]
  );

  meta = with lib; {
    homepage = "https://github.com/robertohuertasm/microserver";
    description = "Simple ad-hoc server with SPA support";
    maintainers = with maintainers; [ flosse ];
    license = licenses.mit;
    mainProgram = "microserver";
  };
}
