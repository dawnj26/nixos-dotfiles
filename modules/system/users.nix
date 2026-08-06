{
  flake.nixosModules.users.dawn = { pkgs, ... }: {
    users.users."dawn" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Donn Jayson";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      initialPassword = "wodotatop10weekly";
      home = "/home/dawn";
    };
  };
}
