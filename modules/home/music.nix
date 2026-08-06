{ config, ... }: {
  flake.homeModules.music =
    let
      user = config.home.username;
    in
    {
      programs.rmpc = {
        enable = true;
      };

      services.mpd = {
        enable = true;
        musicDirectory = "/run/media/${user}/DonnDrive/Music";
      };
    };
}
