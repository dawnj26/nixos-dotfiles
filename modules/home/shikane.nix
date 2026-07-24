{
  services.shikane = {
    enable = true;
    settings = {
      profile = [
        {
          name = "external";
          output = [
            {
              search = "n=HDMI-A-1";
              enable = true;
              mode = "1920x1080@75";
              position = "0,0";
              scale = 1.0;
            }
            {
              search = "n=eDP-1";
              enable = false;
            }
          ];
        }
        {
          name = "internal";
          output = [
            {
              search = "n=eDP-1";
              enable = true;
              mode = "1366x768@60Hz";
              positiion = "0,0";
              scale = 1.0;
            }
          ];
        }
      ];
    };
  };
}
