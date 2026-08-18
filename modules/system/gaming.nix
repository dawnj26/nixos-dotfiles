{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      mangohud
      winetricks
      gamescope
      gamemode
      umu-launcher
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
