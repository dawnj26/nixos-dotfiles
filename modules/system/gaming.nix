{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];

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

  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "always";
      };
      battery = {
        governor = "powersave";
        turbo = "never";
      };
    };
  };
}
