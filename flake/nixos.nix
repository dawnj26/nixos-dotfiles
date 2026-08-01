{inputs, ...}: let
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ../hosts/${name}
      ];
      specialArgs = {inherit inputs;};
    };
in {
  flake.nixosConfigurations = {
    laptop = mkHost "laptop" "x86_64-linux";
  };
  systems = [
    "x86_64-linux"
  ];
  perSystem = {pkgs, ...}: {
    packages.zed-editor-bin = pkgs.callPackage ../packages/zed-editor-bin.nix {};
  };
}
