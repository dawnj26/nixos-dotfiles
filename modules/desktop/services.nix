{
  flake.modules.nixos.desktop = {
    services = {
      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
      upower.enable = true;
      printing.enable = true;
      flatpak.enable = true;
      power-profiles-daemon.enable = true;
    };
  };

  flake.modules.homeManager.desktop = {
    services = {
      udiskie.enable = true;
    };
  };
}
