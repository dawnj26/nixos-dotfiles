{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "run";
        runtimeInputs = [pkgs.runapp];
        text = ''
          #!/usr/bin/env bash

          runapp -d "$PWD" "$@"
        '';
      })
    ];
  };
}
