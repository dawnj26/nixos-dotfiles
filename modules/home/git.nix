{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Donn Jayson Quinto";
        email = "jaysonquinto1@outlook.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      push.autoSetupRemote = true;
      credential.helper = "";
    };
  };
}
