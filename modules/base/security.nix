{
  flake.modules.nixos.base = {
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
