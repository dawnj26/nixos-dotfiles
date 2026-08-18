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
      name = "";
      package = pkgs.adw-gtk3;
    };
    font = {
      name = "Inter";
      size = 12;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };
}
