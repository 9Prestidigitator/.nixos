{
  flake.homeModules.general = {inputs, ...}: {
    imports = [inputs.neovim.homeManagerModules.default];
    programs.Neovim.enable = true;
  };
}
