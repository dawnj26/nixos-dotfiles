{config, ...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    programs.zsh.enable = true;
    users.users.${config.owner.username}.shell = pkgs.zsh;
  };

  flake.modules.homeManager.base = {
    config,
    ...
  }: let
    homePath = config.home.homeDirectory;
    configPath = "${homePath}/nixos-dotfiles";
    starshipPath = "${configPath}/config/starship.toml";
  in {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        z = "run zeditor .";
        nrs = "nh os switch -H laptop --accept-flake-config";
        nru = "nix flake update --flake ${configPath} && nrs";
        x = "eza";
        lg = "lazygit";
      };

      history.size = 10000;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "-alh"
        "--group-directories-first"
        "--show-symlinks"
        "--icons"
        "--no-time"
      ];
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      configPath = starshipPath;
    };
  };
}
