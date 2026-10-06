{
  flake.modules.nixos.base = {pkgs, ...}: {
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

      kernel.sysctl = {
        "vm.max_map_count" = 2147483642;
      };

      loader = {
        limine = {
          enable = true;
          efiSupport = true;
          extraEntries = ''
            /Windows
                protocol: efi
                path: uuid(23add590-bd0d-443b-9f5f-596b6fecd8fe):/EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
        grub.enable = false;
        systemd-boot.enable = false;

        efi.canTouchEfiVariables = true;
        timeout = 3;
      };

      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
    };
  };
}
