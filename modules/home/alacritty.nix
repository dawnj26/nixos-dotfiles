{
  flake.homeModules.alacritty = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 14;
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold Italic";
          };
        };
      };
    };

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
