{inputs, ...}: {
  home.username = "dawn";
  home.homeDirectory = "/home/dawn";
  home.stateVersion = "26.05";

  imports = [
    inputs.walker.homeManagerModules.default
    (inputs.import-tree ./.)
  ];
}
