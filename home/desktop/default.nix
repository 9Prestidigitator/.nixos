{
  lib,
  config,
  niri,
  ...
}: {
  imports = [
    ./niri
    ./noctalia.nix
    ./darkmode.nix
  ];

  xdg.configFile."kwalletrc".text = ''
    [Wallet]
    Enabled=false
    First Use=false
  '';
}
