{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      libreoffice
      qbittorrent
      vesktop
      obsidian
      proton-vpn
      spicetify-cli
      manager-io
      vibe
      spotiflac
      gimp
      spotify-spotx
      localsend
      amberol
    ];

    programs.craftapps = {
      enable = true;
      apps.wordcraft.enable = true;
      apps.pdfcraft.enable = true;
    };
  };
}
