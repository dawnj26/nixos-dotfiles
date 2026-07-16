{
  pkgs,
  config,
  ...
}: let
  configPath = "${config.home.homeDirectory}/nixos-dotfiles#laptop";
in {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      export LD_LIBRARY_PATH="${pkgs.oracle-instantclient.lib}/lib"
    '';

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ${configPath}";
      nru = "sudo nix flake update ${configPath} && sudo nixos-rebuild switch --flake ${configPath}";
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
    presets = ["tokyo-night"];
    enableZshIntegration = true;
  };
}
