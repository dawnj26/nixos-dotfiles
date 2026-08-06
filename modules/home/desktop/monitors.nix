{ config, ... }: {
  flake.homeModules.monitors =
    { pkgs, ... }:
    let
      configDir = "${config.home.homeDirectory}/nixos-dotfiles/config";
    in
    {
      xdg.configFile."hyprmoncfg".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/hyprmoncfg";

      systemd.user.services.hyprmoncfgd = {
        Unit = {
          Description = "Hyprland monitor profile daemon (hyprmoncfgd)";
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          ExecStart = "${pkgs.hyprmoncfg}/bin/hyprmoncfgd --monitors-conf ${configDir}/hypr/monitors.lua --hypr-config ${configDir}/hypr/hyprland.lua";
          Restart = "on-failure";
          RestartSec = 2;
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
