{pkgs, ...}: {
  home.file.".config/chromium-flags.conf".text = ''
    --ozone-platform-hint=auto
    --ozone-platform=wayland
    --enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,CanvasOopRasterization,VaapiVideoEncoder
    --enable-gpu-rasterization
    --enable-zero-copy
  '';

  home.packages = with pkgs; [
    nur.repos.ymstnt.brave-origin
  ];
}
