{ stdenv, bash, git, mktemp, sudo }:
stdenv.mkDerivation {
  name = "update-website";
  src = ./.;
  buildInputs = [ bash git mktemp sudo ];
  installPhase = ''
    mkdir -p $out/bin
    cp update-website $out/bin
    chmod +x $out/bin/update-website
  '';
}
