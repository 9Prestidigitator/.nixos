{
  # This is to be used by other core desktop modules to allow the super key to
  # be tapable where it normally wouldn't.
  # Tapped super key translates to favorites key.
  flake.nixosModules.super-tap = {...}: {
    services.keyd = {
      keyboards.default.settings = {
        settings.overload_tap_timeout = 25;
        main.leftmeta = "overload(meta, favorites)";
      };
      keyboards.qmk = {
        ids = ["cb10:8256" "3434:0430"];
        settings = {
          settings.overload_tap_timeout = 25;
          main.leftmeta = "overload(meta, favorites)";
        };
      };
    };
  };
}
