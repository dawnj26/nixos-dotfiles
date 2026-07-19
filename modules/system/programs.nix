{...}: {
  virtualisation.docker.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.hyprland.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
