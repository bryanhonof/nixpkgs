{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  stdenv,
  Security,
}:

rustPlatform.buildRustPackage rec {
  pname = "zee";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "zee-editor";
    repo = pname;
    tag = "v${version}";
    sha256 = "sha256-/9SogKOaXdFDB+e0//lrenTTbfmXqNFGr23L+6Pnm8w=";
  };

  cargoPatches = [
    # fixed upstream but unreleased
    ./update-ropey-for-rust-1.65.diff
  ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ] ++ lib.optional stdenv.hostPlatform.isDarwin Security;

  # disable downloading and building the tree-sitter grammars at build time
  # grammars can be configured in a config file and installed with `zee --build`
  # see https://github.com/zee-editor/zee#syntax-highlighting
  ZEE_DISABLE_GRAMMAR_BUILD = 1;

  useFetchCargoVendor = true;
  cargoHash = "sha256-auwbpavF/WZQIE/htYXJ4di6xoRtXkBBkP/Bj4lFp6U=";

  meta = with lib; {
    description = "Modern text editor for the terminal written in Rust";
    homepage = "https://github.com/zee-editor/zee";
    license = licenses.mit;
    maintainers = with maintainers; [ booklearner ];
    mainProgram = "zee";
  };
}
