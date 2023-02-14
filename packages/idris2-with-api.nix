{ stdenv, idris2, ... }:

idris2.overrideAttrs (oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ idris2 ];
  buildFlags = [ ];

  postInstall = oldAttrs.postInstall + ''
    IDRIS2_PREFIX=$out $out/bin/idris2 --install idris2api.ipkg
  '';
})
