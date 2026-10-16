{
  flake.modules.homeManager.base = {pkgs, ...}: {
    programs = {
      bat.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      fzf.enable = true;
      gh.enable = true;
      btop.enable = true;
      fastfetch.enable = true;
    };

    home.packages = with pkgs; [hyprpicker ffmpeg];
  };
}
