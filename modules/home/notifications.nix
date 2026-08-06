{
  flake.homeModules.notifications = {
    services.mako = {
      enable = true;
      settings = {
        background-color = "#1a1b26";
        text-color = "#a9b1d6";
        border-color = "#0db9d7";
        progress-color = "#0db9d7";
        default-timeout = 5000;
        ignore-timeout = 1;
        group-by = "app-name,summary,body";
        width = 420;
        outer-margin = 20;
        padding = "10,15";
        border-size = 2;
        max-icon-size = 32;
        layer = "overlay";
        sort = "-time";
        font = "JetBrainsMono Nerd Font 12";
      };
      extraConfig = ''
        [urgency=high]
        border-color=#ff7a93
      '';
    };
  };
}
