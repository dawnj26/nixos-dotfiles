{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        default = {
          center = ["recorder" "clock" "notifications"];
          end = [
            "media"
            "tray"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "session"
          ];
          start = ["workspaces"];
          font_family = "JetBrainsMono Nerd Font Mono";
          layer = "overlay";
          margin_ends = 0;
          radius = 0;
          scale = 0.85;
          shadow = false;
          thickness = 24;
          widget_spacing = 12;
        };
      };

      control_center.calendar = {
        show_events_card = false;
      };

      desktop_widgets = {
        schema_version = 2;
        widget_order = [];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
      };

      location = {
        address = "Bayambang, Philippines";
        auto_locate = true;
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
      };

      plugin_settings = {
        "noctalia/screen_recorder" = {
          copy_to_clipboard = true;
          video_source = "focused";
        };

        "noctalia/wallhaven" = {
          api_key = "pTE1trUv3hqlMmewgDSkD6vvFSqKl0zE";
        };
      };

      # plugins = {
      #   auto_update = "all";
      #   enabled = [
      #     "noctalia/screen_recorder"
      #     "noctalia/wallhaven"
      #     "noctalia/kaomoji"
      #     "nightwatch75/dns-switcher"
      #   ];
      # };

      shell = {
        font_family = "Inter";
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
        time_format = "{:%I:%M %p}";

        greeter_sync.auto_sync = true;

        screenshot = {
          confirm_region = true;
          directory = "${homeDir}/Pictures/Screenshots";
        };
      };

      theme = {
        builtin = "Rosé Pine";
        community_palette = "Oxocarbon";
        mode = "dark";
        source = "builtin";
        wallpaper_scheme = "m3-content";

        templates = {
          builtin_ids = [
            "alacritty"
            "foot"
            "gtk3"
            "gtk4"
            "hyprland"
            "kcolorscheme"
            "qt"
            "starship"
          ];
        };
      };

      wallpaper = {
        directory = "${homeDir}/nixos-dotfiles/wallpapers";
        default.
          path = "${homeDir}/nixos-dotfiles/wallpapers/nature-pink.png";
      };

      widget = {
        battery = {
          hide_when_plugged = true;
          show_label = false;
        };

        brightness = {
          show_label = false;
        };

        clipboard = {
          enabled = false;
        };

        clock = {
          format = "{:%I:%M %p}";
        };

        media = {
          hide_when_no_media = true;
        };

        network = {
          show_label = false;
        };

        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };

        volume = {
          show_label = false;
        };

        workspaces = {
          active_pill_size = 1.0;
          capsule_padding = 8;
          occupied_color = "surface";
        };
      };
    };
  };
}
