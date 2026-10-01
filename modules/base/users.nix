{config, ...}: {
  flake.modules.nixos.base = let
    user = config.owner.username;
  in {
    users.users.${user} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "docker" "gamemode"];
      home = "/home/${user}";
    };
  };
}
