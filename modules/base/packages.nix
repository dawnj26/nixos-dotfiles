{
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [git wget zip unzip unrar tealdeer runapp];
  };
}
