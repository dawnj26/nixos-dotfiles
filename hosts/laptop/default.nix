{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
  };

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
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  virtualisation.docker.enable = true;

  networking.hostName = "laptop";
  networking.wireless.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Manila";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
    pam.services.sddm.enableGnomeKeyring = true; # if using greetd
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.hyprland.enable = true;

  users.users."dawn" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Donn Jayson";
    extraGroups = ["networkmanager" "wheel" "docker"];
    initialPassword = "wodotatop10weekly";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall = {
    enable = true;

    allowPing = true;

    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  system.stateVersion = "26.05";

  home-manager.backupFileExtension = "backup";

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 80;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
    };
  };
}
