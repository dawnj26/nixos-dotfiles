{config, ...}: {
  flake.modules.homeManager.dev = {pkgs, ...}: {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = config.owner.fullName;
          email = config.owner.email;
        };

        init.defaultBranch = "main";
        pull.rebase = false;
        core.editor = "nvim";
        push.autoSetupRemote = true;
        credential.helper = "";
      };
    };

    home.packages = with pkgs; [gnumake bruno lazydocker bun ngrok nix-init];
  };
}
