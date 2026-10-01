{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      libreoffice
      qbittorrent
      vesktop
      obsidian
      proton-vpn
      spicetify-cli
    ];
  };
}
