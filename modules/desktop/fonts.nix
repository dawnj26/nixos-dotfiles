{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.geist-mono
      inter
      ttf-ms-win11-auto
      dejavu_fonts
      ibm-plex
      geist-font
    ];
  };
}
