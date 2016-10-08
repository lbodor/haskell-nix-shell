{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc801" }:

let
  inherit (nixpkgs) pkgs;
  hp = pkgs.haskell.packages.${compiler};
  project = hp.callPackage (import ./default.nix) {};
  drv = pkgs.haskell.lib.addBuildTools project (
    [ hp.cabal-install hp.stack hp.hdevtools ]
  );
in
  if pkgs.lib.inNixShell then drv.env else drv
