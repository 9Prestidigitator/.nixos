{
  flake.nixosModules.keyd = {...}: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [
          "*"
          # qmk boards
          "-cb10:8256"
          "-3434:0430"
          # mouse
          "-1038:1836"
        ];
        settings = {
          main = {
            mouse2 = "leftmeta";
            mouse1 = "esc";
            capslock = "overload(mod5, esc)";
          };
          mod5 = {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            u = "pageup";
            d = "pagedown";
            backspace = "delete";
          };
          "shift:S" = {
            capslock = "capslock";
          };
          "mod5+shift" = {
            g = "end";
          };
        };
      };
    };
  };
}
