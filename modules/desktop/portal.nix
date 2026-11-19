{inputs, ...}: {
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  };

  flake.modules.nixos.desktop = {pkgs, ...}: let
    noctalia = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    xdg.portal = {
      wlr = {
        enable = true;

        settings.screencast = {
          chooser_type = "dmenu";
          chooser_cmd = ''
            ${noctalia}/bin/noctalia dmenu -p "Share which screen?"
          '';
        };
      };
    };
  };
}
