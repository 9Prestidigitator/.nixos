{...}: {
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
          background = "#282828d0";
          corner_r = 8;
          border_width = 0;
          margin_right = 11;
          margin_bottom = 11;
          margin_left = 11;
          margin_top = 11;
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
