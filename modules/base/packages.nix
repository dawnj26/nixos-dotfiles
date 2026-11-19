{
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [git zip unzip unrar tealdeer runapp p7zip];
  };
}
