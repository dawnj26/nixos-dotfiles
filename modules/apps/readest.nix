{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      readest
    ];

    xdg.mimeApps.defaulApplications = {
      "x-scheme-handler/readest" = "readest.desktop";
    };
  };
}
