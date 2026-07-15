{inputs, ...}: {
  home.username = "dawn";
  home.homeDirectory = "/home/dawn";
  home.stateVersion = "26.05";

  imports = [
    ./packages.nix
    inputs.walker.homeManagerModules.default
    ./fonts.nix
    ./session.nix
    ./alacritty.nix
    ./neovim.nix
    ./git.nix
    ./shell.nix
    ./kitty.nix
    ./uwsm.nix
    ./hyprland.nix
    ./gsettings.nix
    ./walker.nix
    ./services.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
