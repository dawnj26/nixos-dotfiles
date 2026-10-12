{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      (writeShellApplication {
        name = "run";
        runtimeInputs = [pkgs.runapp];
        text = ''
          runapp -d "$PWD" "$@"
        '';
      })
      (writeShellApplication {
        name = "xaudio";
        runtimeInputs = [pkgs.ffmpeg];
        text = builtins.readFile ../../scripts/xaudio.sh;
      })
    ];
  };
}
