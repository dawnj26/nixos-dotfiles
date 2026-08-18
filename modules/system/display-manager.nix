{pkgs, ...}: {
  programs.noctalia-greeter = {
    enable = true;

    greeter-args = "";
    settings = {
      appearance = {
        hide_logo = true;
      };
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        layout = "us";
      };
    };
  };
}
