{
  flake.nixosModules.security = {
    services.openssh.enable = true;
    security = {
      rtkit.enable = true;
      polkit.enable = true;
      pam.services.login.enableGnomeKeyring = true;
      pam.services.sddm.enableGnomeKeyring = true;
    };
  };
}
