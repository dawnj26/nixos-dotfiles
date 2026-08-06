{
  flake.nixosModules.packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      tealdeer
      neovim
      bat
      ripgrep
      gdu
      unzip
      curl
      fzf
      fd
      gnumake
      p7zip
      xhost
      gnome-keyring
      polkit_gnome
      unrar
      zip
      bibata-cursors
      ntfs3g
    ];
  }

  ;
}
