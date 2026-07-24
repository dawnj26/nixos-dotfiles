{pkgs, ...}: {
  services = {
    openssh.enable = true;

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      enableHidpi = true;
      theme = "${pkgs.elegant-sddm}/share/sddm/themes/Elegant";
      extraPackages = with pkgs; [
        elegant-sddm
      ];
    };

    xserver.enable = true;
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    accounts-daemon.enable = true;
    dbus.enable = true;

    fstrim.enable = true;

    flatpak.enable = true;
  };
}
