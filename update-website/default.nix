{ stdenv, bash, git, mktemp }:
stdenv.mkDerivation {
  name = "update-website";
  src = ./.;
  buildInputs = [ bash git mktemp ];
  installPhase = ''
    mkdir -p $out/bin
    cp update-website $out/bin
    chmod +x $out/bin/update-website
  '';
}
