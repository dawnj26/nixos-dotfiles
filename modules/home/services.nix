{
  pkgs,
  config,
  ...
}: let
  configDir = "${config.home.homeDirectory}/nixos-dotfiles/config";
in {
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "Polkit Authentication Agent";
      After = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSpec = 10;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  systemd.user.services.hyprmoncfgd = {
    Unit = {
      Description = "Hyprland monitor profile daemon (hyprmoncfgd)";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.hyprmoncfg}/bin/hyprmoncfgd --monitors-conf ${configDir}/hypr/monitors.lua --hypr-config ${configDir}/hypr/hyprland.lua";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  services.hypridle.enable = true;
  services.udiskie.enable = true;
}
