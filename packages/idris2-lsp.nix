{ stdenv, symlinkJoin, clang, idris2-with-api, src, ... }:

stdenv.mkDerivation rec {
  pname = "idris2-lsp";
  version = "0.6.0";

  inherit src;

  buildInputs = [ idris2-with-api ];

  doCheck = false;

  makeFlags = [
    "VERSION_TAG=${version}"
    "PREFIX=$(out)"
  ];

  installTargets = [ "install-only" ];
}