{
  flake.nixosModules.overlay.theme = final: prev: {
    gtk-engine-murrine =
      inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system}.gtk-engine-murrine;
    tokyonight-gtk-theme =
      inputs.nixpkgs-stable.legacyPackages.${prev.stdenv.hostPlatform.system}.tokyonight-gtk-theme;
  };
}
