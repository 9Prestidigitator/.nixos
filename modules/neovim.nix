{
  flake.homeModules.neovim = {inputs, ...}: {
    imports = [inputs.neovim.homeManagerModules.default];
    programs.Neovim.enable = true;
  };
}
