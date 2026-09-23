{pkgs, ...}: let
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

  home.packages = with pkgs; [
    nur.repos.ymstnt.brave-origin
  ];
}
