{...}: {
  virtualisation.docker.enable = true;

  programs = {
    zsh.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    gpu-screen-recorder.enable = true;
  };
}
