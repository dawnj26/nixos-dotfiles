{
  flake.homeModules.portal =
    { inputs, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal
        ];
        configPackages = [
          pkgs.xdg-desktop-portal-gtk
          inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal
        ];
      };
    };
}
