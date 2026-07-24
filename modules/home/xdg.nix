{...}: let
  browser = "brave-origin.desktop";
  pdf = browser;
  image = "org.gnome.eog.desktop";
  video = "mpv.desktop";
in {
  xdg = {
    mimeApps = {
      enable = true;

      defaultApplications = {
        # Browser
        "text/html" = [browser];
        "application/xhtml+xml" = [browser];
        "x-scheme-handler/http" = [browser];
        "x-scheme-handler/https" = [browser];
        "x-scheme-handler/about" = [browser];
        "x-scheme-handler/unknown" = [browser];

        # PDF
        "application/pdf" = [pdf];

        # Images
        "image/jpeg" = [image];
        "image/png" = [image];
        "image/webp" = [image];
        "image/gif" = [image];
        "image/svg+xml" = [image];
        "image/avif" = [image];

        # Videos
        "video/mp4" = [video];
        "video/x-matroska" = [video];
        "video/webm" = [video];
        "video/*" = [video];

        # Audio
        "audio/*" = [video];
      };
    };
  };
}
