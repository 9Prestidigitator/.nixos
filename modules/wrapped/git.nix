{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.max-git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;
      package = pkgs.git;
      env = {
        GIT_AUTHOR_NAME = "9Prestidigitator";
        GIT_AUTHOR_EMAIL = "9Prestidigitator@gmail.com";
      };
    };
  };
}
