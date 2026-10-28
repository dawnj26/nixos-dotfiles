{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      readest
    ];

    xdg = {
      mimeApps.defaultApplications = {
        "x-scheme-handler/readest" = "readest-url.desktop";
      };

      desktopEntries.readest-url = {
        name = "Readest (URL handler)";
        exec = "${pkgs.readest}/bin/readest %U";
        noDisplay = true;
        mimeType = ["x-scheme-handler/readest"];
      };
    };
  };
}
