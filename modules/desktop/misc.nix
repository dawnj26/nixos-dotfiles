{
  flake.modules.nixos.desktop = {
    programs.dconf.enable = true;
    programs.gpu-screen-recorder.enable = true;
  };
}
