{
  flake.modules.homeManager.desktop = {pkgs, ...}: let
    flags = ''
      --ozone-platform-hint=auto
      --ozone-platform=wayland
      --enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder
      --enable-gpu-rasterization
      --enable-zero-copy
    '';
  in {
    home.file.".config/chromium-flags.conf".text = flags;
    home.file.".config/brave-origin-flags.conf".text = flags;

    programs.helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];
      package = pkgs.helium.overrideAttrs (old: final: rec {
        version = "0.20.1.1";
        src = pkgs.fetchurl {
          url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-bin_${version}-1_amd64.deb";
          sha256 = "sha256-HLpZpTAxuGYhbYV4DJBo1x4xiiXhlgJ1LZ46ReGT+l4=";
        };
      });
    };

    home.packages = with pkgs; [
      brave-origin
    ];
  };
}
