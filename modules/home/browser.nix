{pkgs, ...}: {
  home.file.".config/chromium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --ozone-platform=wayland
    --enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder
    --enable-gpu-rasterization
    --enable-zero-copy
  '';

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
    ];
    package = pkgs.helium.overrideAttrs (_: rec {
      version = "0.17.0.1";
      src = pkgs.fetchurl {
        url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-bin_${version}-1_amd64.deb";
        sha256 = "sha256-mFj3RECYtEGkh4Zij1NTG3mWHJV8XUnrP0gX1qsc0MI=";
      };
    });
  };

  home.packages = with pkgs; [
    nur.repos.ymstnt.brave-origin
  ];
}
