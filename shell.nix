with import <nixpkgs> { };
let
  pack = stdenv.mkDerivation {
    name = "pack";
    src = fetchurl {
      # nix-prefetch-url this URL to find the hash value
      url =
        "https://github.com/buildpacks/pack/releases/download/v0.9.0/pack-v0.9.0-linux.tgz";
      sha256 = "1admg8rasqg5m4dg3j5xad92pn0f6a55hq2f7i3vl0n9g8b5hna7";
    };
    phases = [ "installPhase" "patchPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cd $out/bin && tar -zxf $src
    '';
  };
in pkgs.mkShell {
  name = "pack";
  buildInputs = [ pack figlet ];
  shellHook = ''
    figlet ":pack:"
    echo
    echo pack $(pack version)
    echo
  '';
}
