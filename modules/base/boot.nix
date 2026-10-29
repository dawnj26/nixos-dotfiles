{
  flake.modules.nixos.base = {pkgs, ...}: {
    boot = {
      plymouth.enable = true;

      consoleLogLevel = 3;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
        "split_lock_mitigate=0"
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
          extraConfig = ''
            quite: yes
          '';
        };
        grub.enable = false;
        systemd-boot.enable = false;

        efi.canTouchEfiVariables = true;
        timeout = 1;
      };

      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
    };
  };
}
