{
  flake.modules.homeManager.base = {
    programs = {
      bat.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      fzf.enable = true;
      gh.enable = true;
      btop.enable = true;
      fastfetch.enable = true;
    };
  };
}
