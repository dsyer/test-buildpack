with import <nixpkgs> {};
pkgs.mkShell {
  name = "pack";
  buildInputs = [
    (import ./default.nix { inherit pkgs; })
    figlet
  ];
  shellHook = ''
    figlet ":pack:"
    echo
    echo pack `pack version`
    echo
'';
}