{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.neovim.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    # TUI
    vim
    emacs
    lazygit
    btop
  ];

  programs.Neovim.enable = true;

}
