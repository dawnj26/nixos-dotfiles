{...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.opengl.enable = true;

  services.xserver.videoDrivers = ["amdgpu"];

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
