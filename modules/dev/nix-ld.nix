{
  flake.modules.nixos.dev = {pkgs, ...}: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [stdenv.cc.cc.lib zlib openssl icu curl oracle-instantclient.lib];
    };
  };
}
