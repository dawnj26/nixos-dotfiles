{inputs, ...}: {
  flake.modules.homeManager.desktop = {pkgs, ...}: let
    system = pkgs.stdenv.hostPlatform.system;
    hyprPkgs = inputs.hyprland.packages.${system};
  in {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        hyprPkgs.xdg-desktop-portal-hyprland
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        hyprPkgs.xdg-desktop-portal-hyprland
      ];
    };
  };
}
