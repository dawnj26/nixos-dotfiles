{
  flake.nixosModules.dev = {pkgs, ...} : {
    environment.systemPackages = with pkgs; [
      oracle-instantclient
      bruno
      jdk21_headless
    ];
  };
}
