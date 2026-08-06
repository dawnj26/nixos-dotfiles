{
  flake.homeModules.cursor =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;

        gtk = {
          enable = true;
          size = 24;
        };

        hyprcursor = {
          enable = true;
          size = 24;
        };
      };
    };
}
