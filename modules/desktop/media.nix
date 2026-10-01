{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    programs.mpv.enable = true;
    programs.yt-dlp.enable = true;
    home.packages = with pkgs; [cine foliate pinta eog];
  };
}
