{ config, ... }: {
  flake.homeModules.shell =
    {
      pkgs,
      lib,
      ...
    }:
    let
      configPath = "${config.home.homeDirectory}/nixos-dotfiles";
    in
    {
      programs.zsh = {
        enable = true;

        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = lib.mkOrder 1000 ''
          dc() {
              (
                  cd "$1" || return
                  shift
                  docker compose "$@"
              )
          }
          yt-transcript(){
              yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format ttml --convert-subs srt --output "transcript.%(ext)s" $1;
              cat ./transcript.en.srt | sed '/^$/d' | grep -v '^[0-9]*$' | grep -v '\-->' | sed 's/<[^>]*>//g' | tr '\n' ' ' > output.txt;
          }
        '';

        envExtra = ''
          export LD_LIBRARY_PATH="${pkgs.oracle-instantclient.lib}/lib"
        '';

        shellAliases = {
          nrs = "nh os switch -H laptop";
          nru = "sudo nix flake update --flake ${configPath} && nrs";
          x = "eza";
          lg = "lazygit";
          erp-start = "dc \"$HOME/repos/oracle-db\" up -d";
          erp-down = "dc \"$HOME/repos/oracle-db\" down";
          erp-logs = "dc \"$HOME/repos/oracle-db\" logs -f";
        };

        history.size = 10000;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = [ "--cmd cd" ];
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
        presets = [ "tokyo-night" ];
        enableZshIntegration = true;
      };

      home.packages = [
        (pkgs.writeShellApplication {
          name = "screenshot";
          runtimeInputs = with pkgs; [
            grim
            satty
            wl-clipboard
            slurp
            coreutils
          ];
          text = builtins.readFile ../../scripts/screenshot.sh;
        })
        (pkgs.writeShellApplication {
          name = "screenrecord";
          runtimeInputs = with pkgs; [ jq ];
          text = builtins.readFile ../../scripts/screenrecord.sh;
        })
        (pkgs.writeShellApplication {
          name = "lock-in-erp";
          runtimeInputs = with pkgs; [
            libnotify
            docker
          ];
          text = builtins.readFile ../../scripts/lock-in-erp.sh;
        })
        (pkgs.writeShellApplication {
          name = "run";
          runtimeInputs = with pkgs; [ runapp ];
          text = builtins.readFile ../../scripts/run.sh;
        })
      ];
    };
}
