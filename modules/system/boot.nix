{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    loader = {
      limine = {
        enable = true;
        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  };
}
