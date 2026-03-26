{inputs, ...}: {
  flake.homeModules.neovim = {
    imports = [inputs.neovim.homeManagerModules.default];
    programs.Neovim.enable = true;
  };
}
