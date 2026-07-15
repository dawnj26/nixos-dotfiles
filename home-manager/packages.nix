{pkgs, ...}: {
  home.packages = with pkgs; [
    wl-clipboard
    nur.repos.trev.helium
    alacritty
    tree-sitter
    lazygit
    bottom
    nerd-fonts.jetbrains-mono
    nodejs
    python3
    lazygit
    eza
    gh
    rofi
    waybar
    btop
    wlogout
    libreoffice
    nwg-look
    mako
    networkmanagerapplet
    nautilus
    eog
    brightnessctl
    libnotify
    grimblast
    qbittorrent
    zoxide
    zed-editor
    corefonts
    xdg-desktop-portal-gtk
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    wayland-logout
    blueman
    pavucontrol
    inter
    papirus-icon-theme
    tokyonight-gtk-theme
    starship
    hyprpaper
    lazydocker
    git
    heroic
    lutris
    protonup-qt
    vesktop

    # LSP
    lua-language-server
    vtsls
    tailwindcss-language-server
    yaml-language-server
    emmet-ls
    vscode-langservers-extracted
    dockerfile-language-server
    eslint_d
    eslint
    nixd
    deadnix

    # Linters & Formatters
    hadolint
    selene
    stylua
    prettier
    alejandra

    # Debuggers & Internal Binaries
    python3Packages.debugpy
    vscode-js-debug
  ];
}
