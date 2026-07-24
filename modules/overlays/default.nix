{inputs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];
}
