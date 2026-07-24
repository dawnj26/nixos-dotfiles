{
  config,
  pkgs,
  inputs,
  ...
}: let
  hyprConfigPath = "${config.home.homeDirectory}/nixos-dotfiles/config/hypr";
  system = pkgs.stdenv.hostPlatform.system;
in {
  # Add Hyprland lua completions
  home.file."${hyprConfigPath}/.luarc.json".text = ''
    {
      "workspace": {
        "library": [
          "${pkgs.hyprland}/share/hypr/stubs"
        ]
      }
    }
  '';
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprConfigPath;

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    gtk = {
      enable = true;
      size = 24;
    };

    hyprcursor = {
      enable = true;
      size = 24;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };
    font = {
      name = "Inter";
      size = 12;
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "qtct";
  };

  services.mako = {
    enable = true;
    settings = {
      background-color = "#1a1b26";
      text-color = "#a9b1d6";
      border-color = "#0db9d7";
      progress-color = "#0db9d7";
      default-timeout = 5000;
      ignore-timeout = 1;
      layer = "overlay";
      border-radius = 4;
      sort = "-time";
      font = "JetBrainsMono Nerd Font 12";
    };
    extraConfig = ''
      [urgency=high]
      border-color=#ff7a93
    '';
  };
}
