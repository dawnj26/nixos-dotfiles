{pkgs, ...}: let
  config = pkgs.fetchFromGitHub {
    owner = "noelsimbolon";
    repo = "mpv-config";
    rev = "linux";
    sha256 = "sha256-9MINPGVCUFNwTBd2k7MaRlSy8/V3/5zKKjJ4+BnrYOU=";
  };
in {
  xdg.configFile."mpv".source = config;
}
