{
  flake.homeModules.wlr-which-key = {
    pkgs,
    lib,
    ...
  }: let
    mkWlrWhichKeyMenu = name: menu: let
      configFile =
        pkgs.writeText "${name}.yaml"
        (lib.generators.toYAML {} {
          font = "JetBrainsMono Nerd Font 12";
          anchor = "bottom-right";
          background = "#28282860";
          corner_r = 16;
          border_width = 0;
          margin_right = 10;
          margin_bottom = 10;
          margin_left = 10;
          margin_top = 10;
          inhibit_compositor_keyboard_shortcuts = true;
          inherit menu;
        });
    in
      lib.getExe (pkgs.writeShellScriptBin "wlr-which-key-${name}" ''
        exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
      '');
  in {
    _module.args = {
      inherit mkWlrWhichKeyMenu;
    };
  };
}
