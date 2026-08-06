{
  flake.nixosModules.hyprland =
    {
      pkgs,
      inputs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
        package = pkgs.hyprland;
        portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
      };

      programs.uwsm.enable = true;

      environment.systemPackages = with pkgs; [
        uwsm
        hyprcursor
        hyprpaper
      ];
    };
}
