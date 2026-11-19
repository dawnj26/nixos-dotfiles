{inputs, ...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: let
    mango = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
  in {
    programs.mango = {
      enable = true;
      addLoginEntry = false;
    };

    programs.uwsm = {
      enable = true;
      waylandCompositors.mango = {
        prettyName = "Mango";
        comment = "MangoWM managed by UWSM";
        binPath = "${mango}/bin/mango";
      };
    };
  };
  flake.modules.homeManager.desktop = {config, ...}: {
    wayland.windowManager.mango = {
      systemd.enable = false;
    };

    xdg.configFile."mango".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/mango";
  };
}
