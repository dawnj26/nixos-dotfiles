{ config, ... }: {
  flake.nixosModules.programs =
    let
      homeDir = config.users.users.dawn.home;
    in
    {
      virtualisation.docker.enable = true;

      programs = {
        zsh.enable = true;
        dconf.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };

        gpu-screen-recorder.enable = true;
        nh = {
          enable = true;
          clean = {
            enable = true;
            dates = "weekly";
            extraArgs = "--keep 3 --keep-since 3d --optimise";
          };
          flake = "${homeDir}/nixos-dotfiles";
        };
      };
    };
}
