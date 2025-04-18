{
  lib,
  stdenv,
  fetchFromGitHub,
  ocaml,
  findlib,
  ocamlbuild,
  ctypes,
  libsodium,
}:

lib.throwIf (lib.versionAtLeast ocaml.version "5.0")
  "sodium is not available for OCaml ${ocaml.version}"

  stdenv.mkDerivation
  rec {
    pname = "ocaml${ocaml.version}-sodium";
    version = "0.6.0";

    src = fetchFromGitHub {
      owner = "dsheets";
      repo = "ocaml-sodium";
      tag = version;
      sha256 = "124gpi1jhac46x05gp5viykyrafnlp03v1cmkl13c6pgcs8w04pv";
    };

    patches = [
      # ctypes.stubs no longer pulls in bigarray automatically
      ./lib-gen-link-bigarray.patch
    ];

    nativeBuildInputs = [
      ocaml
      findlib
      ocamlbuild
    ];
    propagatedBuildInputs = [
      ctypes
      libsodium
    ];

    strictDeps = true;

    createFindlibDestdir = true;

    hardeningDisable = lib.optional stdenv.hostPlatform.isDarwin "strictoverflow";

    meta = with lib; {
      homepage = "https://github.com/dsheets/ocaml-sodium";
      description = "Binding to libsodium 1.0.9+";
      inherit (ocaml.meta) platforms;
      maintainers = [ maintainers.rixed ];
    };
  }
