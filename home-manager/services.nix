{pkgs, ...}: {
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
}
