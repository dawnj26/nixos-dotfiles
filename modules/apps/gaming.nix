{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.gamemode = {
      enable = true;
    };

    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        mangohud
        gamescope
        umu-launcher
      ];
      remotePlay.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      heroic
      lutris
      protonup-qt
      mangohud
      winetricks
      umu-launcher
    ];
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    programs.lutris = {
      enable = true;
      extraPackages = with pkgs; [
        mangohud
        winetricks
        gamescope
        gamemode
        umu-launcher
      ];
    };
  };
}
