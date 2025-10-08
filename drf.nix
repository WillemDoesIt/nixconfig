{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "davinci-resolve-fixed";
  src = pkgs.davinci-resolve;

  nativeBuildInputs = [pkgs.makeWrapper];

  buildPhase = ''
    mkdir -p $out/bin
    cp -r ${src}/* $out/
  '';

  installPhase = ''
    wrapProgram $out/bin/davinci-resolve \
      --prefix LD_LIBRARY_PATH : ${pkgs.nvidia_x11.lib}/lib
  '';
}
